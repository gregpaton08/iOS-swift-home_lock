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
    
    let reachability = Reachability()!
    
    @objc(reachabilityChangedWithNote:)
    func reachabilityChanged(note: Notification) {
        refreshStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        
        doorLockSwitch.isEnabled = false
        
        if let address = HLSettings.getSetting(.address) as? String, let port = HLSettings.getSetting(.port) as? String {
            homeLock.serverAddress = address
            homeLock.serverPort = port
            
            refreshStatus()
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        refreshStatus()
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
