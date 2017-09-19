//
//  MailHandler.swift
//  AppClub
//
//  Created by Local Admin on 7/26/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import Foundation

class MailHandler{
    func postToServerFunction(data: String) -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/SendMail.php")!)
        request.httpMethod = "POST"
        let postString = "data=\(data)"
        request.httpBody = postString.data(using: .utf8)
        var resultResponse = ""
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            resultResponse = responseString!
        }
        task.resume()
        return resultResponse
    }

}
