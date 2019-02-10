//
//  UILabel.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

extension UILabel {
    func setFont(_ font: FontType) {
        self.font = UIFont(name: font.name, size: self.font.pointSize)
    }
    
    func setFont(_ font: FontType, size: CGFloat) {
        self.font = UIFont(name: font.name, size: size)
    }
}

extension UITextField {
    func setFont(_ font: FontType) {
        self.font = UIFont(name: font.name, size: (self.font?.pointSize)!)
    }
}
