//
//  ContentViewController.swift
//  AppClub
//
//  Created by Local Admin on 8/1/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var ProjectsButton: UIButton!
    @IBOutlet weak var LogoutText: UILabel!
    var count = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        LogoutText.text = "Logout"
        count = 3

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func openProjects(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("https://appdevclub.000webhostapp.com/Website/Projects.html", forKey: "openURL")
    }
    
    @IBAction func LogOut(_ sender: Any) {
        count -= 1
        LogoutText.text = "Press " + String(count) + " more time(s).."
        if(count <= 0){
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "LoggedIn")
        self.performSegue(withIdentifier: "LogoutSegue", sender: self)
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
