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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://192.168.1.168:5555/api/v1/lock_status")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            var lockStatus: Bool?
            if let dictionary = json as? [String: Any] {
                lockStatus = dictionary["status"] as? Bool
            }
            DispatchQueue.main.async {
                self.statusLabel.text = lockStatus! ? "Locked" : "Unlocked"
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

