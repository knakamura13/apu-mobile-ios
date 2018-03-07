//
//  quickSegueVC.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura on 3/7/18.
//  Copyright © 2018 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

class quickSegueVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.popViewController(animated: false)
        performSegue(withIdentifier: "quickToMainSegue", sender: nil)
    }
}
