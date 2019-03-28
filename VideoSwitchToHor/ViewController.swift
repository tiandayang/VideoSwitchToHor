//
//  ViewController.swift
//  VideoSwitchToHor
//
//  Created by 田向阳 on 2019/3/28.
//  Copyright © 2019 田向阳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var playerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.backgroundColor = .cyan
        view.addSubview(playerView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fullVC = FullScreenViewController()
        fullVC.playerView = playerView
        present(fullVC, animated: true, completion: nil)
    }
    
}

