//
//  TodayViewController.swift
//  Widget
//
//  Created by Greg Paton on 10/14/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit
import NotificationCenter
import HomeLockControl

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var doorLockSwitch: UISwitch!
    
    @IBAction func doorLockSwitchPress(_ sender: UISwitch) {
        homeLock.lockDoor(sender.isOn) {
            DispatchQueue.main.async {
                self.refreshStatus()
            }
        }
    }
    
    private let homeLock = HomeLock()
    
    private func refreshStatus() {
        homeLock.getStatus() { (status, error) in
            DispatchQueue.main.async {
                if let lockStatus = status {
                    self.doorLockSwitch.isEnabled = true
                    self.doorLockSwitch.setOn(lockStatus, animated: true)
                } else {
                    self.doorLockSwitch.isEnabled = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        doorLockSwitch.isEnabled = false
        refreshStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        refreshStatus()
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
