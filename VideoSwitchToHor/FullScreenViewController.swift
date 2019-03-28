//
//  FullScreenViewController.swift
//  VideoSwitchToHor
//
//  Created by 田向阳 on 2019/3/28.
//  Copyright © 2019 田向阳. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController ,UIViewControllerTransitioningDelegate {
    
    //MARK: Property
    var superView: UIView?
    var playerView: UIView?{
        didSet{
            superView = playerView?.superview
            let keyWindow = UIApplication.shared.delegate?.window as? UIWindow
            originFrame = superView?.convert(playerView?.frame ?? .zero, to: keyWindow)
        }
    }
    
    var originFrame: CGRect?
    
    //MARK: ControllerLifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControllerFirstData()
        createUI()
        loadData()
        registNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarOrientation(.landscapeRight, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //MARK: LoadData
    private func loadData() {
        
    }
    
    private func initControllerFirstData() {
        
    }
    //MARK: Action
    
    //MARK: AddNotificatoin
    private func registNotification() {
        
    }
    //MARK: CreateUI
    private func createUI() {
        
    }
    //MARK: Helper
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FullScreenAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FullScreenAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.setStatusBarOrientation(.portrait, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //把这个设置为 0  可令 setStatusBarOrientation 方法生效
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.init(rawValue: 0)
    }
    
}
