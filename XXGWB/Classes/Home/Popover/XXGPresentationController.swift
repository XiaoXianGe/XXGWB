//
//  XXGPresentationController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/21.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class XXGPresentationController: UIPresentationController {

    
    //用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews() {
        
        
        presentedView?.frame = CGRect(x: 100, y: 55, width: 200 , height: 250)
    }
    
    
}
