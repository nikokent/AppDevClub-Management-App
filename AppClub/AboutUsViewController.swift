//
//  AboutUsViewController.swift
//  AppClub
//
//  Created by Local Admin on 7/31/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        // Do any additional setup after loading the view.
        myWebView.loadRequest(URLRequest(url: URL(string: defaults.string(forKey: "openURL")!)!))
        myWebView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func MyWebViewGoBack(_ sender: Any) {
        if(myWebView.canGoBack)
        {
            myWebView.goBack()
        }
        else{
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingView.startAnimating()
        loadingView.color = UIColor.darkGray
    }
   
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if (self.myWebView.isLoading == false){
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
