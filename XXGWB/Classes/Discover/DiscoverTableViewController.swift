//
//  DiscoverTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //判读用户是否登录
        if !isLogin
        {
            LoginView?.setUpLoginViewInfo(imageName: "visitordiscover_image_message" , title: "登录后，最新、最热微博尽在掌握，不会再与事实潮流擦肩而过")
            return
        }

    }



}
