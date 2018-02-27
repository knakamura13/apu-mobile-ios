//
//  MenuWebVC.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

class MenuWebVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        webView.delegate = self
        webView.scrollView.bounces = false
        let url = URL(string: clickedHyperlinkURL)
        webView.loadRequest(URLRequest(url: url!))     // load url from previous page click
    }
    
    // Go back to MainVC, reload webview with mobile.apu.edu
    @IBAction func navHome(_ sender: Any) {
        navHomePressed = true   // global: set navigation destination to mobile.apu.edu instead of previous web page
        self.navigationController?.popViewController(animated: false)
    }
    
    // Go back to MainVC, but do not unload the current webpage
    @IBAction func navBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    // When webView finishes loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitUserSelect='text'")!   // Re-enable text selection
    }
    
    // Hide the status bar to enable full screen view
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
