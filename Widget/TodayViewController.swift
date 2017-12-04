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

class TodayViewController: UIViewController, NCWidgetProviding, LockViewDelegate {
    
    @IBOutlet weak var lockView: LockView!
    
    @IBAction func doorLockSwitchPress(_ sender: UISwitch) {
        homeLock.lockDoor(sender.isOn) {
            DispatchQueue.main.async {
                self.refreshStatus()
            }
        }
    }
    
    private let homeLock = HomeLock()
    
    private func refreshStatus() {
        lockView.isSpinning = true
        homeLock.getStatus() { (status, error) in
            DispatchQueue.main.async {
                self.lockView.isSpinning = false
                if let lockStatus = status {
//                    self.lockView.isEnabled = true
                    self.lockView.isLocked = lockStatus
                } else {
//                    self.lockView.isEnabled = false
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
        
        lockView.isSpinning = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier...")
        }
        
//        lockView.isEnabled = false
        
        if let address = HLSettings.getSetting(.address) as? String {
            homeLock.address = address
        }
        
        refreshStatus()
        
        lockView.delegate = self
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        refreshStatus()
        
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Lock View Delegate
    
    func handleTapFor(lockView: LockView) {
        lockView.isSpinning = true
        homeLock.lockDoor(!lockView.isLocked) {
            DispatchQueue.main.async {
                self.refreshStatus()
            }
        }
    }
    
}
