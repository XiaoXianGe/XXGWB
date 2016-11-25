//
//  ProfileTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/24.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //判读用户是否登录
        if !isLogin
        {
            LoginView?.setUpLoginViewInfo(imageName: "visitordiscover_image_profile" , title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }

    }

}
