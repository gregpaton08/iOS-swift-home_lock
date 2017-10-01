//
//  ViewController.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lockButton: UIButton!
    
    @IBAction func lockButtonPress(_ sender: UIButton) {
        var request = URLRequest(url: getLockStatusUrl()!)
        request.httpMethod = "PUT"
        let jsonData = "{\"status\":false}".data(using: String.Encoding.utf8)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(describing: jsonData?.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
        }
        task.resume()
    }
    
    private let serverAddress = "192.168.1.168"
    private let serverPort = "5555"
    
    private func getLockStatusUrl() -> URL? {
        return URL(string: "http://" + serverAddress + ":" + serverPort + "/api/v1/lock_status")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task = URLSession.shared.dataTask(with: getLockStatusUrl()!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            var lockStatus: Bool?
            if let dictionary = json as? [String: Any] {
                lockStatus = dictionary["status"] as? Bool
            }
            DispatchQueue.main.async {
                self.statusLabel.text = lockStatus! ? "Locked" : "Unlocked"
                self.lockButton.titleLabel?.text = lockStatus! ? "Unlock" : "Lock"
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

