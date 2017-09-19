//
//  ViewController.swift
//  AppClub
//
//  Created by Local Admin on 7/26/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var SignInBTN: UIButton!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    let mail = MailHandler()
    let postF = PostFunctions()
    let defaults = UserDefaults.standard
    var accessed = false
    var originPoint = 0 as CGFloat
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.EmailField.delegate = self
        self.NameField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        //accessed = postF.CheckLogin(Username: defaults.string(forKey: "Username")!, Email: defaults.string(forKey: "Email")!)
        print(accessed)
        originPoint = self.MainView.frame.origin.y
        let getLocation = PostFunctions()
        let defaults = UserDefaults.standard
        getLocation.GetLocation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if(defaults.bool(forKey: "LoggedIn"))
        {
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }

    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboard open")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.MainView.frame.origin.y = -keyboardSize.height       }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.MainView.frame.origin.y != 0{
                self.MainView.frame.origin.y = originPoint
                
            }
        }
    }

    
    
    @IBAction func ClearAllData(_ sender: Any) {
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }

    @IBAction func SignIn(_ sender: Any) {
        if(EmailField.text == "")
        {
            let alert = UIAlertController(title: "Error!", message: "Please fill all fields!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
            
        }
        else if (EmailField.text?.contains("wsu.edu"))!{
        print(postF.AddMember(Authenticate: "mcnixo", Username: NameField.text!, Email: EmailField.text!))
            defaults.set(NameField.text,forKey: "Username")
            defaults.set(EmailField.text, forKey: "Email")
            defaults.set(true, forKey: "LoggedIn")
            performSegue(withIdentifier: "HomeSegue", sender: nil)
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.EmailField){
            self.NameField.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
        }
        return true
    }
    

}

