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
        setUpNavigation()
    }
    
    private func setUpNavigation(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action:#selector(HomeTableViewController.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick))
        
        //设置导航栏的标题
        let titleBtn = TitleButton()
        titleBtn.setTitle("小贤哥", for: UIControlState.normal)
        
        titleBtn.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(titleBtn:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.titleView = titleBtn
    }
    
    ///点击标题
    @objc private func titleBtnClick(titleBtn:TitleButton){
        XGLog(message: "titleBtnClick")
        
        titleBtn.isSelected = !titleBtn.isSelected

        
        //创建pop的标题菜单
        let sb = UIStoryboard(name: "Popover", bundle: nil)
        
        guard let menuView = sb.instantiateInitialViewController() else
        {
            return
        }
        //自定义转场动画
        
        //代理
        menuView.transitioningDelegate = self
        //样式
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom

        present(menuView, animated: true, completion: nil)

    }
    @objc private func leftBtnClick(){
        XGLog(message: "left")
    }
    @objc private func rightBtnClick(){
        XGLog(message: "right")
    }
    //判断标题pop是否被点击
    var isPresent = false
    lazy var animatorManager = XXGPresentationManager()

}

extension HomeTableViewController :UIViewControllerTransitioningDelegate
{
    //返回一个转场动画的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return XXGPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    //设置开始转场的如何出现
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        return self
    }
    //设置如何消失消失
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        return self
    }
    
}

extension HomeTableViewController : UIViewControllerAnimatedTransitioning
{
    //告诉系统展示和消失的动画时长
    //暂时用不上
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 998
    }
    
    //专门用于管理model如何展示和消失的，展示和消失都会调用该方法
    //只要实现了这个方法，就不会再有系统的modal动画，所有的动画都需要我们自己添加
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        if isPresent {
            
            guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else{
                return
            }
            
            
            
            //将需要弹出的试图添加到containerView上
            transitionContext.containerView.addSubview(toView)
            //先将试图变为原来的百分百
            toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
            //设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            //执行动画
            UIView.animate(withDuration: 0.2, animations: {() -> Void in toView.transform = CGAffineTransform.identity}){(_) -> Void in
                //必须结束动画
                transitionContext.completeTransition(true)
            }
            
            
        }else{
            
            guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        }
        
        
        
        
        
    }
}

