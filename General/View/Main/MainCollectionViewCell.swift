//
//  MainCollectionViewCell.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.rounded()
        backView.shadow()
        lbTitle.setFont(.regular)
        lbTitle.textColor = .white
    }
    
    func setup(menu: Menu) {
        lbTitle.text = menu.title
        backView.backgroundColor = menu.color
        imgIcon.image = menu.image
    }

}
