//
//  BaseTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/25.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    //重写父类方法，判断是否登录，如果没有登录，显示登录的界面，如果登录了，则显示微博数据
    var isLogin = true
    
    //访客试图
    var LoginView : isLoginView?

    override func loadView() {
        
        isLogin ? super.loadView(): ifIsLoginState()
        
    }
  
    //如果还没有登录
    func ifIsLoginState()  {
        
        LoginView = isLoginView.setUpLoginView()
        
        view = LoginView
        
        LoginView?.loginBtn.addTarget(self, action: #selector(BaseTableViewController.loginBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        
        LoginView?.registerBtn.addTarget(self, action: #selector(BaseTableViewController.registerBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableViewController.registerBtnClick(btn:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableViewController.loginBtnClick(btn:)))
    }
    
    @objc private func loginBtnClick(btn:UIButton){
        
        XGLog(message: btn);
        
    }
    
    @objc private func registerBtnClick(btn :UIButton)
    {
        XGLog(message: btn);
    }
    
    
    
    
}
