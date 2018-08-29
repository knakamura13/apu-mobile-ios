//
//  APUMobileVC.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

class APUMobileVC: UIViewController, UIWebViewDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    
    
    // MARK: Properties
    
    /// Options: mobile, mobile-beta, mobile-kyle, mobile-monte, mobile-mario, mobile-test, mobile-upgrade, mobile-vanilla
    let environment = "mobile"
    
    
    //MARK: View Loading
    
    override func viewWillAppear(_ animated: Bool) {
        webView.delegate = self
        webView.scrollView.bounces = false     // prevent webpage from moving when user scrolls
        
        // If the user pressed the Home button from the previous MenuWebVC
        if navHomePressed {
            self.reloadAPUMobile()
            navHomePressed = false
        }
    }
    
    override func viewDidLoad() {
        self.reloadAPUMobile()
    }

    
    // MARK: Web View
    
    func reloadAPUMobile() {
        let url = URL(string: "https://\(environment).apu.edu")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    /**
     Function is called whenever a webpage is about to load.
     Non-native URLs get directed to a seperate WebView to prevent pages from removing/hiding the mobile.apu.edu interface.
    */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let requestString = String(describing: request)
        clickedHyperlinkURL = requestString
        
        if navigationType == .linkClicked {
            if requestString.contains(environment) && !(requestString.contains("den.apu.edu")) {
                // navigate normally for native HighPoint links that are NOT den.apu.edu (CAS) links
            } else if requestString.contains("youtube.com") {
                if let url = URL(string: String(describing: request)) {
                    UIApplication.shared.open(url, options: [:])    // Deep link the url to an app, if it exists, or Safari
                    return false
                }
            } else {
                performSegue(withIdentifier: "segueToPopoutWebViewVC", sender: nil)    // segue to MenuWebVC
                return false
            }
        }
        return true
    }
}
