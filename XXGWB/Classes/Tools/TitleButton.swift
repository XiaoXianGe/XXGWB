//
//  TitleButton.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/13.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }

    func setUpUI() {
        setImage(UIImage(named:"navigationbar_arrow_down"), for: UIControlState.normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: UIControlState.selected)
        sizeToFit()
    }
    
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        
        super.setTitle((title ?? "") + "  ", for: state)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.width)!
        
    }
    
}
