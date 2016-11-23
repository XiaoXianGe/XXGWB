//
//  MainViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.orange

        addALLChildViewController()
        
    }
    
    func addALLChildViewController() {
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(PorfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    
    
    
    
    
    func addChildViewController(_ childController: UIViewController , title :String,imageName :String) {
        
        let nameBundle = Bundle.main.infoDictionary!["CFBundleExecutable"]
        
        NSLog(nameBundle as! String)
        
        
        let text = "测试"
    
        NSLog(text)
        
        let text2 = "没有推送提醒"
        
        NSLog(text2)
        
        
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named:imageName)
        let image = imageName + "_highlighted"
        childController.tabBarItem.selectedImage = UIImage(named:image)

        //加导航条
        let nav = UINavigationController(rootViewController:childController)
        
        
        addChildViewController(nav)
        
        
    }
    
}
