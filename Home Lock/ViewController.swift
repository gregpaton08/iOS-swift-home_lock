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
        if let address = HLSettings.getSetting(.address) as? String {
            homeLock.address = address
            return true
        }
        return false
    }
    
    @IBAction func pressSettingsButton(_ sender: UIButton) {
        showSettingsAlert()
    }
    
    private func showSettingsAlert() {
        let settingsAlert = UIAlertController(title: "Lock Address", message: "Enter the address of the home lock", preferredStyle: .alert)
        settingsAlert.addTextField(configurationHandler: nil)
        if let address = HLSettings.getSetting(.address) as? String {
            settingsAlert.textFields?.first!.text = address
        }
        let okayAction = UIAlertAction(title: "Okay", style: .default) { [weak settingsAlert] action in
            let address = settingsAlert?.textFields?.first?.text ?? ""
            HLSettings.setSetting(address, forKey: .address)
            self.homeLock.address = address
            self.refreshStatus()
        }
        settingsAlert.addAction(okayAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        settingsAlert.addAction(cancelAction)
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    /// Refresh the lock status.
    private func refreshStatus() {
        lockView.isSpinning = true
        homeLock.getStatus() { (status, error) in
            DispatchQueue.main.async {
                self.lockView.isSpinning = false
                if status != nil {
                    self.lockView.isEnabled = true
                    self.lockView.isLocked = status!
                } else {
                    self.lockView.isEnabled = false
                    let alertController = UIAlertController(title: "Could not reach server", message: "Please double check your settings.", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
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
            showSettingsAlert()
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
            }
        }
    }
}
