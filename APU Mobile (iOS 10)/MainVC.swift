//
//  ViewController.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        webView.delegate = self
        webView.scrollView.bounces = false     // prevent webpage from moving when user scrolls
        
        let url = URL(string: globalUrl)!
        self.webView.loadRequest(URLRequest(url: url))
    }
    
    // Function is called whenever a webpage is about to load.
    // Ensures that non-mobile URLs get directed to a seperate VC to prevent pages from overriding/hiding the mobile.apu.edu interface.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let requestString = String(describing: request)
        clickedHyperlinkURL = requestString
        
        if navigationType == .linkClicked {
            if requestString.contains("mobile") {
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
