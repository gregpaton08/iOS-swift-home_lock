//
//  SettingsTableViewController.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    
    private func validate() -> Bool {
        return isValidAddress(addressTextField.text) && isValidPort(portTextField.text)
    }
    
    private func isValidAddress(_ address: String?) -> Bool {
        if address == nil {
            return false
        }
        
        let parts = address!.components(separatedBy: ".")
        let numbers = parts.flatMap() { Int($0) }
        return parts.count == 4 && numbers.count == 4 && numbers.filter() { $0 > 0 && $0 < 256 }.count == 4
    }
    
    private func isValidPort(_ port: String?) -> Bool {
        if port == nil {
            return false
        }
        
        if let portNumber = Int(port!) {
            return portNumber > 0 && portNumber < 1 << 16
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let defaults = UserDefaults.standard
        if let address = defaults.object(forKey: AppSettings.SettingKeys.address.rawValue) as? String, let port = defaults.object(forKey: AppSettings.SettingKeys.port.rawValue) as? String {
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
        
        let defaults = UserDefaults.standard
        defaults.set(addressTextField.text!, forKey: AppSettings.SettingKeys.address.rawValue)
        defaults.set(portTextField.text!, forKey: AppSettings.SettingKeys.port.rawValue)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !validate() {
            return false
        }
        
        return true
    }

}
