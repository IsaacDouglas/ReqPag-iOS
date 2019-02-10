//
//  Color.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

enum Color {
    case one, two, tree, four
    
    var color: UIColor {
        switch self {
        case .one:
            return UIColor(red: 229/255, green: 75/255, blue: 133/255, alpha: 1)
        case .two:
            return UIColor(red: 26/255, green: 112/255, blue: 249/255, alpha: 1)
        case .tree:
            return UIColor(red: 43/255, green: 90/255, blue: 132/255, alpha: 1)
        case .four:
            return UIColor(red: 27/255, green: 177/255, blue: 228/255, alpha: 1)
        }
    }
}
