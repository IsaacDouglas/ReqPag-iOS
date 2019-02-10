//
//  UIViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func backAction(){
        if let nav = navigationController, nav.viewControllers.count != 1 {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
