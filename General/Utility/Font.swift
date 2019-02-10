//
//  Fonts.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import Foundation

enum FontType: String {
    case regular, medium, bold
    
    var name: String {
        switch self {
        case .regular:
            return "Montserrat-Regular"
        case .medium:
            return "Montserrat-Medium"
        case .bold:
            return "Montserrat-Bold"
        }
    }
}
