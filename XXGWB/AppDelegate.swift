//
//  AppDelegate.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
//        window?.backgroundColor = UIColor.gray
//        
//        window?.rootViewController = MainViewController()
//        
//        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        UITabBar.appearance().tintColor = UIColor.orange

        return true
    }
    
}

//自定义打印方法-XGLog
func XGLog<T>(message:T,fileName:String = #file ,methodName:String = #function,lineNumber :Int = #line) {
    
    #if DEBUG
    
//    let kong = "."

    print(  message  )
    
//    print( "*** 自定义Log *** : " + ((fileName as NSString).pathComponents.last!) + kong + methodName)

    #endif
}




