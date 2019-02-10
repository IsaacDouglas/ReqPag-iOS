//
//  HistoricTableViewCell.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class HistoricTableViewCell: UITableViewCell {

    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbTitleFrom: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTitleTo: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.rounded()
        backView.shadow()
        lbFrom.setFont(.regular)
        lbTo.setFont(.regular)
        lbValue.setFont(.bold)
        lbTitleFrom.setFont(.bold)
        lbTitleTo.setFont(.bold)
        lbTitleFrom.text = Localized.from
        lbTitleTo.text = Localized.to
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func setup(transaction: Transaction) {
        if transaction.origem.nome == Constants.id {
            lbValue.text = "- R$\(transaction.valorTransacao)"
            lbValue.textColor = Color.one.color
        } else {
            lbValue.text = "+ R$\(transaction.valorTransacao)"
            lbValue.textColor = Color.two.color
        }
        lbFrom.text = transaction.origem.nome
        lbTo.text = transaction.destino.nome
    }
}
