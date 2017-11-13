//
//  ViewController.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit
import HomeLockControl

class ViewController: UIViewController, LockViewDelegate {
    
    @IBOutlet weak var lockView: LockView!
    
    private let homeLock = HomeLock()
    
    /// Load user settings from UserDefaults.
    private func loadSettings() -> Bool {
        if let address = HLSettings.getSetting(.address) as? String, address.count > 0, let port = HLSettings.getSetting(.port) as? String, port.count > 0 {
            homeLock.serverAddress = address
            homeLock.serverPort = port
            return true
        }
        return false
    }
    
    /// Refresh the lock status.
    private func refreshStatus() {
        homeLock.getStatus() { (status, error) in
            if status != nil {
                DispatchQueue.main.async {
//                    lockView.isEnabled = true
                    self.lockView.isLocked = status!
                }
            } else {
//                DispatchQueue.main.async {
//                    let alertController = UIAlertController(title: "Error", message: "Could not connect to server", preferredStyle: .alert)
//                    let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//                    alertController.addAction(cancelAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
            }
        }
    }
    
    @objc func applicationDidBecomeActive() {
        refreshStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        
        lockView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // If the settings fail to load then segue to the settings page.
        if !loadSettings() {
//            performSegue(withIdentifier: "showSettings", sender: self)
        }
        
        refreshStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // If a lock status GET request is in progress cancel it when exiting the view.
        homeLock.cancelStatusRequest()
    }
    
    // MARK: - Lock View Delegate
    
    func handleTapFor(lockView: LockView) {
        lockView.isSpinning = true
        homeLock.lockDoor(!lockView.isLocked) {
            DispatchQueue.main.async {
                self.refreshStatus()
                self.lockView.isSpinning = false
            }
        }
    }
}
