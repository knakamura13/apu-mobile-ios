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
    
    @IBAction func navigateBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
