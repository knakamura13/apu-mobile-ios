//
//  ViewController.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit
import WebKit

// Global variables
var clickedHyperlinkURL = String()

class MainVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        webView.delegate = self
        webView.scrollView.bounces = false
        let url = URL(string: "https://mobile.apu.edu/")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // Disable user selection
        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitUserSelect='none'")!
    }

    /*
        Description: function is called whenever a webpage is about to load. Used to ensure that non-mobile.apu.edu URLs get directed to a seperate VC because otherwise the webpage replaces/hides the mobile.apu.edu interface.
    */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let requestString = String(describing: request)
        
        if navigationType == .linkClicked {
            print("You clicked a hyperlink: \(String(describing: request))")
            clickedHyperlinkURL = requestString
            
            if requestString.contains("mobile.apu.edu") {  // url contains 'mobile.apu.edu'
                // navigate normally
            } else if requestString.contains("youtube.com") {
                if let url = URL(string: String(describing: request)) {     // convert the URLRequest to URL
                    UIApplication.shared.open(url, options: [:])            // open the url in Youtube or Safari if Youtube fails
                    return false
                }
            } else {
                performSegue(withIdentifier: "segueToMenu", sender: nil)
            }
            return true
        }
        
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
