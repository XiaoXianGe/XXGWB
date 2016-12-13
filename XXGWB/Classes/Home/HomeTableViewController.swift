//
//  HomeTableViewController.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/11/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       //判读用户是否登录
        if !isLogin{
            LoginView?.setUpLoginViewInfo(imageName: nil , title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        //添加导航栏按钮-通过添加Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action:#selector(HomeTableViewController.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick))
        
        //设置导航栏的标题
        let titleBtn = TitleButton()
        titleBtn.setTitle("小贤哥", for: UIControlState.normal)
        titleBtn.setImage(UIImage(named:"navigationbar_arrow_down"), for: UIControlState.normal)
        titleBtn.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(titleBtn:)), for: UIControlEvents.touchUpInside)
        titleBtn.sizeToFit()
        navigationItem.titleView = titleBtn
        
       

    }
    
    @objc private func titleBtnClick(titleBtn:TitleButton){
        titleBtn.isSelected = !titleBtn.isSelected
    }
    @objc private func leftBtnClick(){
        XGLog(message: "left")
    }
    @objc private func rightBtnClick(){
        XGLog(message: "right")
    }
}
