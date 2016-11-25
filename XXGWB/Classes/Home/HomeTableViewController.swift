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
        if !isLogin
        {
            LoginView?.setUpLoginViewInfo(imageName: nil , title: "关注一些人，回这里看看有什么惊喜")
            return
        }
    }
}
