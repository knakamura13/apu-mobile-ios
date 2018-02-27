//
//  ViewController.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

var shouldRepeat: Bool = true
var testBool: Bool = false
var testVar: Int = 0

class MainVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    let environment = "mobile" // Options: mobile, mobile-beta, mobile-kyle, mobile-monte, mobile-test, mobile-upgrade, mobile-vanilla
    let username = "knakamura13"
    let password = "Bwilkinsp7" // pls don't hack me
    
    var timeBool: Bool! = false
    var timer: Timer!
    var timer2: Timer!
    
    // Runs each time this VC appears
    override func viewWillAppear(_ animated: Bool) {
        webView.delegate = self
        webView.scrollView.bounces = false     // prevent webpage from moving when user scrolls
        
        // If the user pressed the Home button from the previous MenuWebVC
        if navHomePressed {
            let url = URL(string: "https://\(environment).apu.edu")
            webView.loadRequest(URLRequest(url: url!))
            navHomePressed = false
        }
    }
    
    // Runs one time during app startup
    override func viewDidLoad() {
        let url = URL(string: "https://\(environment).apu.edu")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    func loginUser(username: String?, password: String?) {
        // Run JavaScript script to automatically login the user
        _ = webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');" +
            "script.type = 'text/javascript';" +
            "script.text = \"function insertLoginDetails() { " +
                "var userNameField = document.getElementsByTagName('input')[1];" +
                "var passwordField = document.getElementsByTagName('input')[2];" +
            
                "userNameField.value = '\(username!)';" +
                "passwordField.value = '\(password!)';" +
            
                "var loginButton = document.getElementsByTagName('button')[1];" +
                "loginButton.click();" +
            "}\";" +
            "document.getElementsByTagName('head')[0].appendChild(script);")!
        webView.stringByEvaluatingJavaScript(from: "insertLoginDetails();")!
    }
    
    // Web page finishes loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if testVar < 2 {
            loginUser(username: self.username, password: self.password)
        }
        
        let when = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: when){
            if testVar < 2 {
                self.loginUser(username: self.username, password: self.password)
            }
        }
    }
    
    // Function is called whenever a webpage is about to load.
    // Ensures that non-mobile URLs get directed to a seperate VC to prevent pages from overriding/hiding the mobile.apu.edu interface.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let requestString = String(describing: request)
        if requestString.contains("dashboard") {
            testVar += 1
        }
        clickedHyperlinkURL = requestString
        
        if navigationType == .linkClicked {
            if requestString.contains(environment) {
            // navigate normally
            } else if requestString.contains("youtube.com") {
                if let url = URL(string: String(describing: request)) {
                    UIApplication.shared.open(url, options: [:])            // open the url in Youtube, or Safari if Youtube fails
                    return false
                }
            } else {
                performSegue(withIdentifier: "segueToMenu", sender: nil)    // segue to MenuWebVC
                return false
            }
        }
        return true
    }
    
    // Hide the status bar to enable full screen view
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}
