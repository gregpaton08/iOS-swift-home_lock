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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let address = HLSettings.getSetting(.address) as? String, let port = HLSettings.getSetting(.port) as? String {
            addressTextField.text = address
            portTextField.text = port
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let _ = HLSettings.setSetting(addressTextField.text!, forKey: .address)
        let _ = HLSettings.setSetting(portTextField.text!, forKey: .port)
    }

}
