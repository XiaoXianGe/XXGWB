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
    var isLogin = false
    
    //访客试图
    var LoginView : isLoginView?

    override func loadView() {
        
        isLogin ? super.loadView(): ifIsLoginState()
        
    }
  
    
    func ifIsLoginState()  {
        
        LoginView = isLoginView.setUpLoginView()

        view = LoginView
    }
    
    
    
}
