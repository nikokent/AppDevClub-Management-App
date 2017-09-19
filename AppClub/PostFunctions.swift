//
//  PostFunctions.swift
//  AppClub
//
//  Created by Local Admin on 7/27/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import Foundation

class PostFunctions{
    
    func CheckLogin(Username: String, Email: String) -> Bool{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/CheckUser.php")!)
        request.httpMethod = "POST"
        let postString = "Username=\(Username)"
        request.httpBody = postString.data(using: .utf8)
        var resultResponse = ""
        var result = false
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
            print(Email)
            resultResponse = responseString!
            if(responseString?.contains(Email))!{
                result = true
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "LoggedIn")
            }
            else{
                result = false
                let defaults = UserDefaults.standard
                defaults.set(false, forKey: "LoggedIn")
            }
        }
        task.resume()
        return result
    }
    
    func AddMember(Authenticate: String, Username: String, Email: String) -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/AddMember.php")!)
        request.httpMethod = "POST"
        let postString = "Authenticate=\(Authenticate)&Username=\(Username)&Email=\(Email)"
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
    
    func GetText() -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/GetText.php")!)
        request.httpMethod = "POST"
        let postString = ""
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
            let defaults = UserDefaults.standard
            defaults.set(responseString!, forKey: "chatBody")
        }
        task.resume()
        return resultResponse
    }
    
    func PostText(MyString: String) -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/PostText.php")!)
        request.httpMethod = "POST"
        let postString = "email=\(MyString)"
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

    func GetLocation() -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/getLocation.php")!)
        request.httpMethod = "POST"
        let postString = ""
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
            let defaults = UserDefaults.standard
            defaults.set(responseString!, forKey: "MeetingLocation")
        }
        task.resume()
        return resultResponse
    }
    
    func SignIn() -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/SignIn.php")!)
        request.httpMethod = "POST"
        let defaults = UserDefaults.standard
        let postString = "Username=" + defaults.string(forKey: "Username")!
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
            let defaults = UserDefaults.standard
            defaults.set(responseString!, forKey: "MeetingLocation")
        }
        task.resume()
        return resultResponse
    }

    
    func isLoggedIn() -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/isLoggedIn.php")!)
        request.httpMethod = "POST"
        let defaults = UserDefaults.standard
        let postString = "Username=" + defaults.string(forKey: "Username")!
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
            let defaults = UserDefaults.standard
            defaults.set(responseString!, forKey: "isLoggedIn")
        }
        task.resume()
        return resultResponse
    }

    func GetNotifications() -> String{
        var request = URLRequest(url: URL(string: "https://appdevclub.000webhostapp.com/getNotifications.php")!)
        request.httpMethod = "POST"
        let postString = ""
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
            let defaults = UserDefaults.standard
            defaults.set(responseString!, forKey: "Announcements")
        }
        task.resume()
        return resultResponse
    }


    
}
