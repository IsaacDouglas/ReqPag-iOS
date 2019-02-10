//
//  Transaction.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class Transactions: Codable {
    var transacoes: [Transaction] = []
    var saldo: String = ""
}

class Transaction: Codable {
    var valorTransacao: Double = 0
    var origem: Origin!
    var destino: Origin!
}

class Origin: Codable {
    var nome: String = ""
    var telefone: String = ""
}
