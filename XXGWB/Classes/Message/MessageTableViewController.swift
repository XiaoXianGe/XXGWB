//
//  MessageTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //判读用户是否登录
        if !isLogin
        {
            LoginView?.setUpLoginViewInfo(imageName: "visitordiscover_image_message" , title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            return
        }
 
    }

 
}
