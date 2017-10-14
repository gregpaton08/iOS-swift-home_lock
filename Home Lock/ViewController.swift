//
//  ViewController.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var serverAddress = ""
    var serverPort = ""

    @IBOutlet weak var lockButton: UIButton!
    
    @IBAction func lockButtonPress(_ sender: UIButton) {
        let dataString: String?
        switch sender.titleLabel?.text ?? "" {
        case "Lock":
            dataString = "{\"status\":true}"
        case "Unlock":
            dataString = "{\"status\":false}"
        default:
            return
        }
        
        sender.setTitle(sender.title(for: .normal)! + "ing...", for: .normal)
        
        // Create a PUT request.
        var request = URLRequest(url: getLockStatusUrl()!)
        request.httpMethod = "PUT"
        
        // Add the JSON data to the request.
        let jsonData = dataString!.data(using: String.Encoding.utf8)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(describing: jsonData?.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // TODO: handle error cases.
            DispatchQueue.main.async {
                self.refreshStatus()
            }
        }
        
        task.resume()
    }
    
    private let homeLock = HomeLock()
    private var lockStatusGetDataTask: URLSessionDataTask?
    
    /// Load user settings from UserDefaults.
    private func loadSettings() {
        let defaults = UserDefaults.standard
        if let address = defaults.object(forKey: AppSettings.SettingKeys.address.rawValue) as? String, address.characters.count > 0, let port = defaults.object(forKey: AppSettings.SettingKeys.port.rawValue) as? String, port.characters.count > 0 {
            serverAddress = address
            serverPort = port
        } else {
            performSegue(withIdentifier: "showSettings", sender: self)
        }
    }
    
    private func getLockStatusUrl() -> URL? {
        return URL(string: "http://" + serverAddress + ":" + serverPort + "/api/v1/lock_status")
    }
    
    /// Refresh the lock status.
    private func refreshStatus() {
//        // If the request is already in progress then don't request again.
//        if lockStatusGetDataTask?.state == .running {
//            return
//        }
//        
//        lockStatusGetDataTask = URLSession.shared.dataTask(with: getLockStatusUrl()!) { (data, response, error) in
//            if error == nil {
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//                var lockStatus: Bool?
//                if let dictionary = json as? [String: Any] {
//                    lockStatus = dictionary["status"] as? Bool
//                }
//                DispatchQueue.main.async {
//                    self.lockButton.setTitle(lockStatus! ? "Unlock" : "Lock", for: .normal)
//                }
//            } else {
//                let alertController = UIAlertController(title: "Error", message: "Could not connect to server", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
//        
//        lockStatusGetDataTask?.resume()
        homeLock.getStatus() { (status, error) in
            if status != nil {
                DispatchQueue.main.async {
                    self.lockButton.setTitle(status! ? "Unlock" : "Lock", for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: "Could not connect to server", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let config = URLSession.shared.configuration
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        
        loadSettings()
        
        refreshStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
        
        refreshStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // If a lock status GET request is in progress cancel it when exiting the view.
        if lockStatusGetDataTask?.state == .running {
            lockStatusGetDataTask?.cancel()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

