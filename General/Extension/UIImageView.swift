//
//  UIImageView.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import UIKit

extension UIImageView {
    func generateQRCode(text: String, inputCorrectionLevel: Level = .M) {
        guard !text.isEmpty else { return }
        
        let data = text.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue(inputCorrectionLevel.rawValue, forKey: "inputCorrectionLevel")
        
        let qrcodeImage: CIImage = filter!.outputImage!
        
        let scaleX = frame.size.width / qrcodeImage.extent.size.width
        let scaleY = frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        image = UIImage(ciImage: transformedImage)
    }
    
    enum Level: String {
        case L, M, Q, H
    }
}
