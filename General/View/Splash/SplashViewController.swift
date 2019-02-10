//
//  SplashViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }

    @objc func timerAction() {
        let main = MainViewController()
        let nav = UINavigationController(rootViewController: main)
        nav.navigationBar.prefersLargeTitles = true
        present(nav, animated: false, completion: nil)
    }
}
