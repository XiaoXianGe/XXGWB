//
//  TitleButton.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/13.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setTitleColor(UIColor.black, for: UIControlState.normal)
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.width)!

    }

}
