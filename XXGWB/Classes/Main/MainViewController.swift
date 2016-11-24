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
    
    //动态加载tabbar
    func addALLChildViewController() {
        
        //获取json文件路径
        guard  let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            return
        }
        guard let data = NSData(contentsOfFile: filePath) else {
            return
        }
        
        do {
            let obj = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : AnyObject]]
            
            for dict in obj {
                let title = dict["title"] as? String
                let vcName = dict["vcName"] as? String
                let imageName = dict["imageName"] as? String
                addChildViewController(childControllerName: vcName, title: title, imageName: imageName, kong: ".")
            }

            
        } catch  {
            addChildViewController(childControllerName:"HomeTableViewController", title: "首页", imageName: "tabbar_home" ,kong:".")
            addChildViewController(childControllerName:"MessageTableViewController", title: "消息", imageName: "tabbar_message_center" ,kong:".")
            addChildViewController(childControllerName: "NullViewController", title: "", imageName: "", kong: ".")
            
            addChildViewController(childControllerName:"DiscoverTableViewController", title: "发现", imageName: "tabbar_discover" ,kong:".")
            addChildViewController(childControllerName:"PorfileTableViewController", title: "我", imageName: "tabbar_profile" ,kong:".")
        }
    }
    
    //通过传入的类名创建对应的控制器！！！
    func addChildViewController(childControllerName: String? , title :String?,imageName :String? ,kong : String) {
        
        guard  let nameBundle = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String  else {
            XGLog(message: "获取命名空间失败,停止运行，return出去")
            return
        }
        
        var clss : AnyClass? = nil
        if let vcName = childControllerName {
            clss = NSClassFromString(nameBundle + kong + vcName)
        }

        guard let typeCls = clss as? UITableViewController.Type else {
            XGLog(message: "clss不能当做控制器，停止运行，return出去")
            return
        }
        
        let childController = typeCls.init()
        
        childController.title = title
        
        if let ivName = imageName {
            
            childController.tabBarItem.image = UIImage(named:ivName)
            let image = ivName + "_highlighted"
            childController.tabBarItem.selectedImage = UIImage(named:image)
        }
        
        //加导航条
        let nav = UINavigationController(rootViewController:childController)
        
        addChildViewController(nav)
        
    }
    
    //MARK: - 懒加载
    
}
