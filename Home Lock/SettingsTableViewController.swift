//
//  SettingsTableViewController.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit
import HomeLockControl

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let address = HLSettings.getSetting(.address) as? String {
            addressTextField.text = address
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let _ = HLSettings.setSetting(addressTextField.text!, forKey: .address)
    }

}
