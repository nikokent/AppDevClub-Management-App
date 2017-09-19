//
//  ChatViewController.swift
//  AppClub
//
//  Created by Local Admin on 7/27/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UIApplicationDelegate {
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var WriteFieldView: UIView!

    @IBOutlet weak var ChatTextView: UITextView!
    @IBOutlet weak var WriteTextField: UITextField!
    @IBOutlet weak var TextFieldView: UIView!
    @IBOutlet weak var MessageField: UITextField!
    let serverHandle = PostFunctions()
    let defaults = UserDefaults.standard
    var boxOrigin = 0
    let screenSize: CGRect = UIScreen.main.bounds
    var showing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        showing = false
        defaults.set(false, forKey: "Keyboard")

       boxOrigin = Int(self.TextFieldView.frame.origin.y)
        self.MessageField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if(defaults.object(forKey: "chatBody") != nil){
            self.ChatTextView.text = defaults.string(forKey: "chatBody")
        
        }
        if(self.ChatTextView.text.isEmpty){
            LoadingIndicator.startAnimating()
        }
        else{
            LoadingIndicator.stopAnimating()
        }
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("LoadText"), userInfo: nil, repeats: true)
        var timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("checkText"), userInfo: nil, repeats: true)
        self.MessageField.endEditing(true)
    }
    func checkText(){
        if(self.ChatTextView.text.isEmpty){
            LoadingIndicator.startAnimating()
        }
        else{
            LoadingIndicator.stopAnimating()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollDown(){
        let bottom = ChatTextView.contentSize.height
        print("HERE IS THE HEIGHT: ")
        print(ChatTextView.frame.size.height)
        ChatTextView.setContentOffset(CGPoint(x: 0, y: bottom - ChatTextView.frame.size.height), animated: true)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.ChatTextView.endEditing(true)
        self.view.endEditing(true)
        self.MessageField.endEditing(true)
    }
    
    func LoadText(){
        var data = self.ChatTextView.text
        serverHandle.GetText()
        if(data != defaults.string(forKey: "chatBody")){
            self.ChatTextView.text = defaults.string(forKey: "chatBody")
            scrollDown()
        }
       
    }
    @IBAction func SendText(_ sender: Any) {
        if(self.MessageField.text?.isEmpty == false){
        print("ACTIVATED!!!!")
        var chatBody = "\n\n-\(defaults.string(forKey: "Username")!): "
        chatBody += self.WriteTextField.text!
        self.WriteTextField.text! = ""
        serverHandle.PostText(MyString: chatBody)
        }
        else{
            print("ERROR!!!")
        }
    }
    func keyboardWillShow(notification: NSNotification) {
        print("keyboard open")
        if(showing == false){
                   if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.TextFieldView.frame.origin.y = screenSize.height - (keyboardSize.height + self.TextFieldView.frame.height)
                    showing = true
            }
        }
        
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        showing = false
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.TextFieldView.frame.origin.y != 0{
                self.TextFieldView.frame.origin.y = CGFloat(boxOrigin)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(self.MessageField.text?.isEmpty == false)
        {
            SendText((Any).self)
        }
        self.view.endEditing(true)
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(defaults.bool(forKey: "Keyboard") != nil && defaults.bool(forKey: "Keyboard") == true){
            defaults.set(false, forKey: "Keyboard")
            
            if self.TextFieldView.frame.origin.y != 0{
                    self.TextFieldView.frame.origin.y = CGFloat(boxOrigin)
                    defaults.set(false, forKey: "Keyboard")
                }
            
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
