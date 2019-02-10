//
//  Payment.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import Foundation

class Payment: Codable {
    var descricao: String = ""
    var destino: String = ""
    var origem: String = ""
    var valor: String = ""
    
    enum CodingKeys: String, CodingKey {
        case descricao
        case destino
        case origem
        case valor
    }
}
