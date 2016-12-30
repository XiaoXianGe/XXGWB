//
//  HomeTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       //判读用户是否登录
        if !isLogin{
            LoginView?.setUpLoginViewInfo(imageName: nil , title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        //添加导航栏按钮-通过添加Button
        setUpNavigation()
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.titleChange), name: NSNotification.Name(rawValue: XXGPresentationManagerDidPresented), object: animatorManager)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeTableViewController.titleChange), name: NSNotification.Name(rawValue: XXGPresentationManagerDidDismissed), object: animatorManager)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func titleChange()
    {
        titleButton.isSelected = !titleButton.isSelected
    }
    
    private func setUpNavigation(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action:#selector(HomeTableViewController.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick))
        navigationItem.titleView = titleButton
    }
    
    // MARK: --- 内部方法
    ///点击标题
    @objc private func titleBtnClick(titleBtn:TitleButton){
        XGLog(message: "titleBtnClick")
        
        //修改按钮状态
        //titleBtn.isSelected = !titleBtn.isSelected

        //创建pop的标题菜单
        let sb = UIStoryboard(name: "Popover", bundle: nil)
        
        guard let menuView = sb.instantiateInitialViewController() else
        {
            return
        }
        //自定义转场动画
        
        //自定义代理
        menuView.transitioningDelegate = animatorManager
        //样式
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom

        present(menuView, animated: true, completion: nil)

    }
    @objc private func leftBtnClick(){
        XGLog(message: "left")
    }
    @objc private func rightBtnClick(){
        //创建二维码控制器
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        //跳转到二维码控制器
        present(vc, animated: true, completion: nil)
    }

    // MARK: --- 懒加载
    //封装代理
    lazy var animatorManager :XXGPresentationManager =
        {
            let manager = XXGPresentationManager()
            manager.presentFrame = CGRect(x: 90, y: 50, width: 200 , height: 300)
            return manager
        }()
    //懒加载标题Btn
    private lazy var titleButton : TitleButton = {

        //设置导航栏的标题
        let Btn = TitleButton()
        Btn.setTitle("小贤哥", for: UIControlState.normal)
        
        Btn.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(titleBtn:)), for: UIControlEvents.touchUpInside)
        return Btn
        
    }()
}




