//
//  QRCodeViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/27.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    //底部工具条
    @IBOutlet weak var customTabBar: UITabBar!
    
    //冲击波Image
    @IBOutlet weak var scanLineView: UIImageView!
    
    //容器view的高度
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    
    //冲击波顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    
    //扫描结果文本
    @IBOutlet weak var customLabel: UILabel!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //默认选中第一个item
        customTabBar.selectedItem = customTabBar.items?.first
        
        //监听底部工具条点击
        customTabBar.delegate = self
        
        //开始扫描二维码
        scanQRCode()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func scanQRCode() {
        
        //1.判断输入能否添加到会话中
        if !(session?.canAddInput(input))!
        {
            return
        }
        //2.判断输出能够添加到会话中
        if !(session?.canAddOutput(output))!
        {
            return
        }
        //3.添加输入和输出到会话中
        session?.addInput(input)
        session?.addOutput(output)
        
        //4.设置输出能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //5.设置监听，监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //6.添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        //6.开始扫描
        session?.startRunning()
        
    }
    
    func startAnimation()
    {
        //设置冲击波底部和容器视图顶部对齐
        scanLineCons.constant = -containerHeightCons.constant
        
        view.layoutIfNeeded()
        //执行扫描动画
        UIView.animate(withDuration: 1.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineCons.constant = self.containerHeightCons.constant
            self.view.layoutIfNeeded()
        }
    }
    
    //关闭
    @IBAction func closeQRCodeClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //相册
    @IBAction func photoClick(_ sender: UIBarButtonItem) {
        XGLog(message: "相册")
        
    }

    // MARK: --- 懒加载
    ///输入对象
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device:device)
    }()
    
    ///会话
    private lazy var session: AVCaptureSession? = {
       return AVCaptureSession()
    }()
    
    ///输出对象
    private lazy var output: AVCaptureMetadataOutput = {
       return AVCaptureMetadataOutput()
    }()
    
    //预览图层
    private lazy var previewLayer : AVCaptureVideoPreviewLayer = {
       
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        return layer!
    }()
}

extension QRCodeViewController : UITabBarDelegate
{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        //根据选中的按钮重新设置二维码的容器高度
        containerHeightCons.constant = (item.tag == 1) ? 150 : 300
        view.layoutIfNeeded()
        
        //移除动画
        scanLineView.layer.removeAllAnimations()
        
        //重新开始动画
        startAnimation()

    }
}

extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate
{
    //只要扫描到结果就会调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        customLabel.text = (metadataObjects.last as AnyObject).stringValue
        
    }
}



