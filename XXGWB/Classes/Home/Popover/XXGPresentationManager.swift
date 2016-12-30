//
//  XXGPresentationManager.swift
//  XXGWB
//
//  Created by 好采猫 on 2016/12/22.
//  Copyright © 2016年 好采猫. All rights reserved.
//

import UIKit

let XXGPresentationManagerDidPresented = "XXGPresentationManagerDidPresented"
let XXGPresentationManagerDidDismissed = "XXGPresentationManagerDidDismissed"

class XXGPresentationManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
{
    //判断标题pop是否被点击
    var isPresent = false
    
    //保存菜单的尺寸
    var presentFrame = CGRect.zero
    
    //MARK : - UIViewControllerTransitioningDelegate
    //返回一个转场动画的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let pc = XXGPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentFrame = presentFrame
        return pc
    }
    
    //设置开始转场的如何出现
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        //通知-首页标题状态改变
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: XXGPresentationManagerDidPresented), object: self)
        return self
    }
    //设置如何消失消失
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        //通知-首页标题状态改变
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: XXGPresentationManagerDidDismissed), object: self)
        return self
    }
    
    //MARK : - UIPresentationController
    
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
            
            willPresentedVC(using: transitionContext)
        }else{
            
            willDismissedVC(using: transitionContext)
            
        }
    }
    
    //执行展现的动画
    private func willPresentedVC(using transitionContext: UIViewControllerContextTransitioning)
    {
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
        

    }
    
    //执行消失的动画
    private func willDismissedVC(using transitionContext: UIViewControllerContextTransitioning)
    {
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
