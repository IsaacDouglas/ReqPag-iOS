//
//  Requester.swift
//  recPag
//
//  Created by Isaac Douglas on 10/02/19.
//  Copyright © 2019 Isaac Douglas. All rights reserved.
//

import Foundation

class Requester {
    
    static func getRequest(url link: String,
                    onError: @escaping (Error) -> Void,
                    onSucess: @escaping (Data) -> Void) {
        
        let url = URL(string: link)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    onError(error!)
                }
                return
            }
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                onSucess(data)
            }
            
        })
        task.resume()
    }
    
    static func postRequest(url link: String,
                            payment: Payment,
                            onError: @escaping (Error) -> Void,
                            onSucess: @escaping (Data) -> Void) {
        
        let url = URL(string: link)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(payment)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    onError(error!)
                }
                return
            }
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                onSucess(data)
            }
            
        })
        task.resume()
    }
}
