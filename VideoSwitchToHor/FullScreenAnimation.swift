//
//  FullScreenAnimation.swift
//  VideoSwitchToHor
//
//  Created by 田向阳 on 2019/3/28.
//  Copyright © 2019 田向阳. All rights reserved.
//

import UIKit

class FullScreenAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    let WINDOW_HEIGHT = UIScreen.main.bounds.height
    let WINDOW_WIDTH = UIScreen.main.bounds.width

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        if toVC?.isKind(of: FullScreenViewController.self) ?? false{
            pushAnimation(transitionContext: transitionContext)
        }else if fromVC?.isKind(of: FullScreenViewController.self) ?? false{
            popAnimation(transitionContext: transitionContext)
        }
    }
    
    
    private func pushAnimation(transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? FullScreenViewController, let playerView = toVC.playerView, let originFrame = toVC.originFrame else {
            transitionContext.completeTransition(false)
            return
        }
        let containView = transitionContext.containerView
        containView.addSubview(toVC.view)
        toVC.view.addSubview(playerView)
        playerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        toVC.view.frame = originFrame
        playerView.frame = toVC.view.bounds

        let duration = self.transitionDuration(using: transitionContext)
        let endFrame = CGRect(x: -(WINDOW_HEIGHT - WINDOW_WIDTH)/2, y: (WINDOW_HEIGHT - WINDOW_WIDTH)/2, width: WINDOW_HEIGHT, height: WINDOW_WIDTH)
        let transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        UIView.animate(withDuration: duration , animations: {
            toVC.view.frame = endFrame
            toVC.view.transform = transform
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    private func popAnimation(transitionContext: UIViewControllerContextTransitioning){
        guard let fromVC = transitionContext.viewController(forKey: .from) as? FullScreenViewController, let playerView = fromVC.playerView, let originFrame = fromVC.originFrame, let superView = fromVC.superView else {
            transitionContext.completeTransition(false)
            return
        }

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration , animations: {
            fromVC.view.transform = .identity
            fromVC.view.frame = originFrame
        }) { (finish) in
            superView.addSubview(playerView)
            playerView.frame = CGRect(x: 0, y: 0, width: self.WINDOW_WIDTH, height: 200)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
