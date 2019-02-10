//
//  Constants.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import Foundation

class Constants {
    static let urlBase = "http://10.98.0.147:9000/recpag/api/v1/transacao"
    static var urlPayment: String {
        return urlBase + "/pagamento"
    }
    static var urlTransaction: String {
        return urlBase + "/?pag=0&ord=id&dir=DESC&conta=" + id
    }
    static let id = "96728947248"
}
