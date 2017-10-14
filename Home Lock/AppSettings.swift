//
//  AppSettings.swift
//  Home Lock
//
//  Created by Greg Paton on 10/1/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import Foundation

class AppSettings {
    
    enum SettingKeys: String {
        case address
        case port
    }
    
    static private var validator: Dictionary<SettingKeys, (String) -> Bool> = [
        .address : { (address) in
            let parts = address.components(separatedBy: ".")
            let numbers = parts.flatMap() { Int($0) }
            return parts.count == 4 && numbers.count == 4 && numbers.filter() { $0 > 0 && $0 < 256 }.count == 4
        },
        .port : { (port) in
            if let portNumber = Int(port) {
                return portNumber > 0 && portNumber < 1 << 16
            }
            return false
        }
    ]
    
    class func getSetting(_ key: SettingKeys) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key.rawValue)
    }
    
    class func setSetting(_ setting: Any?, forKey key: SettingKeys) -> Bool {
        if let settingString = setting as? String {
            if validator[key]!(settingString) {
                let defaults = UserDefaults.standard
                defaults.set(setting, forKey: key.rawValue)
                return true
            }
        }
        return false
    }
    
}
