//
//  ViewController.swift
//  heart
//
//  Created by Mert Neşvat on 11/9/19.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        HealthKitManager.shared.requestAuth()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(activate)))
    }
    
    @objc func activate() {
        HealthKitManager.shared.readData()
    }


}

