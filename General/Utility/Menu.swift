//
//  Menu.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

enum Menu: String {
    case pay, sale, history, wallet
    
    var color: UIColor {
        return compose.color
    }
    
    var title: String {
        return compose.title
    }
    
    var subtitle: String {
        return compose.subtitle
    }
    
    var image: UIImage? {
        return compose.image
    }
    
    var compose: (title: String, subtitle: String, color: UIColor, image: UIImage?) {
        switch self {
        case .pay:
            return (Localized.pay, Localized.payDetail, Color.one.color, Icon.pay)
        case .sale:
            return (Localized.sale, Localized.saleDetail, Color.two.color, Icon.card)
        case .history:
            return (Localized.history, "", Color.tree.color, Icon.history)
        case .wallet:
            return (Localized.wallet, "", Color.four.color, Icon.wallet)
        }
    }
}
