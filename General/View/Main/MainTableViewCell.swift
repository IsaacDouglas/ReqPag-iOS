//
//  MainTableViewCell.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backView.rounded()
        backView.shadow()
        imgIcon.rounded()
        lbTitle.setFont(.bold)
        lbTitle.textColor = .white
        lbSubtitle.setFont(.regular)
        lbSubtitle.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(menu: Menu) {
        lbTitle.text = menu.title
        backView.backgroundColor = menu.color
        imgIcon.image = menu.image
        lbSubtitle.text = menu.subtitle
    }
    
}
