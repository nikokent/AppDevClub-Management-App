//
//  ProjectsViewController.swift
//  AppClub
//
//  Created by Local Admin on 8/5/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var projectsWebView: UIWebView!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectsWebView.loadRequest(URLRequest(url: URL(string: defaults.string(forKey: "openURL")!)!))
        // Do any additional setup after loading the view.
        projectsWebView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func BackTrack(_ sender: Any) {
        

    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingView.startAnimating()
        loadingView.color = UIColor.darkGray
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        if (self.projectsWebView.isLoading == false){
            loadingView.stopAnimating()
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
