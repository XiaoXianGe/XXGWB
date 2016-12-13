//
//  UIBarButtonItem+Extension.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/13.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    convenience init(imageName:String ,target:AnyObject? , action :Selector) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
        
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)

        self.init(customView:btn)
        
        
    }
}
