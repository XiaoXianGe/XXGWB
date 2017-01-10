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

    //扫描容器
    @IBOutlet weak var customContainerView: UIView!
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
    
    // MARK: --- 关闭扫描和打开相册
    //关闭
    @IBAction func closeQRCodeClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //相册
    @IBAction func photoClick(_ sender: UIBarButtonItem) {
        
        //打开相册
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            return
        }
        
        //创建相册控制器
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        
        //弹出相册控制器
        present(imagePickerVC, animated: true, completion: nil)
        
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
        let out = AVCaptureMetadataOutput()
        
        //1、获取屏幕的frame
        let viewRect = self.view.frame
        //2、获取扫描容器的frame
        let containerRect = self.customContainerView.frame
        let x = containerRect.origin.y / viewRect.height
        let y = containerRect.origin.x / viewRect.width
        let width = containerRect.height / viewRect.height
        let height = containerRect.width / viewRect.width
        
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        return out
    }()
    
    //预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
       
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        return layer!
    }()
}

extension QRCodeViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        XGLog(message: info)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        guard let ciImage = CIImage(image:image)  else {
            return
        }
        
        //从选中的图片中读取二维码数据
        //1、创建忆哥探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyLow])
        //2、利用探测器识别二维码
        let results = detector?.features(in: ciImage)
        //3、取出探测器的数据
        for result in results! {
            XGLog(message: (result as! CIQRCodeFeature).messageString)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
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
        //1、显示结果
        customLabel.text = (metadataObjects.last as AnyObject).stringValue
    }
    
    
    
}



