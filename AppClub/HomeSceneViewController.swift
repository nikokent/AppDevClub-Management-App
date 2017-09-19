//
//  HomeSceneViewController.swift
//  AppClub
//
//  Created by Local Admin on 7/27/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class HomeSceneViewController: UIViewController {
    @IBOutlet weak var LoadingAnnouncements: UIActivityIndicatorView!
    @IBOutlet weak var AnnouncementsPage: UITextView!
    @IBOutlet weak var isLoggedInPrompt: UILabel!
    @IBOutlet weak var TestLabel: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(defaults.string(forKey: "isLoggedIn") == "1"){
            isLoggedInPrompt.text = "Signed In"
            isLoggedInPrompt.textColor = UIColor.green
        }
        else{
            isLoggedInPrompt.text = "Not Signed In"
            isLoggedInPrompt.textColor = UIColor.red
        }
        
        // Do any additional setup after loading the view.
        
        var timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: ("checkSignIn"), userInfo: nil, repeats: true)
        var timer2 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: ("checkAnnouncements"), userInfo: nil, repeats: true)
        var timer3 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: ("checkSignIn"), userInfo: nil, repeats: true)
        checkSignIn()
        checkAnnouncements()
        if(AnnouncementsPage.text.isEmpty){
            LoadingAnnouncements.startAnimating()
        }
    }
    @IBAction func GoToWebView(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("https://appdevclub.000webhostapp.com/Website/index.html", forKey: "openURL")
    }
    
    func checkAnnouncements(){
        let handler = PostFunctions()
        handler.GetNotifications()
        AnnouncementsPage.text = defaults.string(forKey: "Announcements")
        if(AnnouncementsPage.text.isEmpty == false){
            LoadingAnnouncements.stopAnimating()
        }
    }
    
    func checkSignIn(){
        let handler = PostFunctions()
        handler.isLoggedIn()
        if(defaults.string(forKey: "isLoggedIn") == "1"){
            isLoggedInPrompt.text = "Signed In"
            isLoggedInPrompt.textColor = UIColor.green
        }
        else if(defaults.string(forKey: "isLoggedIn") == "0"){
            isLoggedInPrompt.text = "Check Schedule"
            isLoggedInPrompt.textColor = UIColor.black
        }
        else{
            isLoggedInPrompt.text = "Not Signed In"
            isLoggedInPrompt.textColor = UIColor.red
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(defaults.object(forKey: "Email") != nil){
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn(_ sender: Any) {
        let signIn = PostFunctions()
        signIn.SignIn()
        checkSignIn()
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
