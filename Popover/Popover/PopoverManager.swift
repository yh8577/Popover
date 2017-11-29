//
//  PopoverManager.swift
//
//  Created by jyh on 2017/11/30.
//  Copyright © 2017年 jyh. All rights reserved.
//

import UIKit

class PopoverManager: NSObject , UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    /// 定义标记记录当前是否是展现
    fileprivate var isPresent = false
    
    /// 保存菜单的尺寸
    var presentFrame = CGRect.zero
    
    // MARK: - UIViewControllerTransitioningDelegate
    // 该方法用于返回一个负责转场动画的对象
    // 可以在该对象中控制弹出视图的尺寸等
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let pc = PopoverPresentedView(presentedViewController: presented, presenting: presenting)

        pc.presentFrame =  presentFrame
        return pc
    }
    
    // 该方法用于返回一个负责转场如何出现的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        
        isPresent = true
        // 发送一个通知, 告诉调用者状态发生了改变
//        NotificationCenter.default.post(name: Notification.Name(rawValue: PopoverManagerDidPresented), object: self)
        return self
    }
    
    // 该方法用于返回一个负责转场如何消失的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        // 发送一个通知, 告诉调用者状态发生了改变
//        NotificationCenter.default.post(name: Notification.Name(rawValue: PopoverManagerDidDismissed), object: self)
        return self
    }
    
    // MARK: - UIPresentationController
    // 告诉系统展现和消失的动画时长
    // 暂时用不上
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.5
    }
    
    // 专门用于管理modal如何展现和消失的, 无论是展现还是消失都会调用该方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        // 0.判断当前是展现还是消失
        if isPresent
        {
            // 展现
            willPresentedController(transitionContext)
            
        }else
        {
            // 消失
            willDismissedController(transitionContext)
        }
    }
    
    /// 执行展现动画
    fileprivate func willPresentedController(_ transitionContext: UIViewControllerContextTransitioning)
    {
        // 1.获取需要弹出视图
        // 通过ToViewKey取出的就是toVC对应的view
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else
        {
            return
        }
        
        // 2.将需要弹出的视图添加到containerView上
        transitionContext.containerView.addSubview(toView)
        
        // 3.执行动画
        toView.alpha = 0
//        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
        // 设置锚点
//        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void in
            
            toView.alpha = 0.8
//            toView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        }, completion: { (_) -> Void in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
    }
    /// 执行消失动画
    fileprivate func willDismissedController(_ transitionContext: UIViewControllerContextTransitioning)
    {
        // 1.拿到需要消失的视图
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else
        {
            return
        }
        // 2.执行动画让视图消失
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            // 突然消失的原因: CGFloat不准确, 导致无法执行动画, 遇到这样的问题只需要将CGFloat的值设置为一个很小的值即可
            fromView.alpha = 0
//            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
            }, completion: { (_) -> Void in
                // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
                transitionContext.completeTransition(true)
        })
    }

}
