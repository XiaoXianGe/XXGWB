//
//  isLoginView.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/25.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class isLoginView: UIView {
    
    @IBOutlet weak var registerBtn: UIButton!//注册按钮
    @IBOutlet weak var loginBtn: UIButton!//登录按钮
    @IBOutlet weak var rotationImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func setUpLoginViewInfo(imageName:String?,title:String) {
        
        titleLabel.text = title
        
        guard let name = imageName else {
            //imageName如果等于空，没有传值，表示首页
            //启动动画
            startAniamtion()

            return
        }
        rotationImageView.isHidden = true
        iconImageView.image = UIImage(named:name)
    }
    
    
    //MARK : - 动画
    private func startAniamtion() {
        
        //创建动画
        let anim = CABasicAnimation(keyPath:"transform.rotation")
        
        //设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 8.0
        anim.repeatCount = MAXFLOAT
        
        //view消失，会停止动画，想持续执行的话要设置
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层上
        rotationImageView.layer.add(anim, forKey: nil)
        
    }
    
    
    //类方法+
    class func setUpLoginView() ->isLoginView {
        
        return Bundle.main.loadNibNamed("isLoginView", owner: nil, options: nil)?.last as! isLoginView
        
        
    }
    
}
