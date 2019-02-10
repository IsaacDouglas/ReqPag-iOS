//
//  SaleViewController.swift
//  recPag
//
//  Created by Isaac Douglas on 09/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

class SaleViewController: UIViewController {

    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Receber"
        navigationItem.largeTitleDisplayMode = .never
        
        tfPrice.keyboardType = .decimalPad
        tfPrice.text = "0".currencyInputFormatting()
        tfPrice.setFont(.regular)
        lbTitle.text = "Digite o valor a ser recebido"
        lbTitle.setFont(.bold)
        lbTitle.textColor = .white
        
        backView.rounded()
        backView.shadow()
        backView.backgroundColor = Color.two.color
        hideKeyboardWhenTappedAround()
        
        let ViewForDoneButtonOnKeyboard = UIToolbar()
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: Localized.ok, style: .done, target: self, action: #selector(self.doneBtnFromKeyboardClicked))
        ViewForDoneButtonOnKeyboard.items = [btnDoneOnKeyboard]
        tfPrice.inputAccessoryView = ViewForDoneButtonOnKeyboard
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        doneBtnFromKeyboardClicked()
    }
    
    @objc func doneBtnFromKeyboardClicked() {
        tfPrice.resignFirstResponder()
        if let amount = tfPrice.text {
            let format = amount.currencyInputFormatting()
            let result = encode(value: format)
            print(result)
            imgQRCode.generateQRCode(text: result)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.imgQRCode.alpha = 1
            })
        }
    }

    @IBAction func lbCurrencyChange(_ sender: UITextField) {
        if let amount = sender.text {
            let format = amount.currencyInputFormatting()
            tfPrice.text = format
        }
    }
    
    @IBAction func lbCurrencyBegin(_ sender: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgQRCode.alpha = 0
        })
    }
    
    func encode(value: String) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let payment = Payment()
        payment.valor = "\(value.dropFirst(3))"
        payment.origem = ""
        payment.destino = Constants.id
        payment.descricao = "\(value)"
        let datas = try! encoder.encode(payment)
        return String(data: datas, encoding: .utf8)!
    }
}
