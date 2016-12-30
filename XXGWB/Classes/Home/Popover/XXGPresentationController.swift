//
//  XXGPresentationController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/21.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class XXGPresentationController: UIPresentationController {

    //保存菜单的尺寸
    var presentFrame = CGRect.zero
    
    //用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews() {
        
        presentedView?.frame = presentFrame //CGRect(x: 90, y: 50, width: 200 , height: 250)
        
        coverButton.addTarget(self, action:#selector(XXGPresentationController.clickCoverBtn), for: UIControlEvents.touchUpInside)
        
        containerView?.insertSubview(coverButton, at: 0)
    }
    
    //MARK : - 内部控制方法
    @objc private func clickCoverBtn() {
       
        presentedViewController.dismiss(animated: true, completion: nil)
        
        
    }
    
    //MARK : - 懒加载
    private var coverButton : UIButton = {
        
        let btn  =  UIButton()
        
        btn.frame = UIScreen.main.bounds
        btn.backgroundColor = UIColor.clear
        
        return btn
        
    }()
    
    
    
}
