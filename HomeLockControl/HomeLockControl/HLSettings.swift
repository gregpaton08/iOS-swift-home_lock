//
//  HLSettings.swift
//  HomeLockControl
//
//  Created by Greg Paton on 10/14/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import Foundation

public class HLSettings {
    
    public enum SettingKeys: String {
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
    
    static private let suiteName = "group.GSP.TodayExtensionSharingDefaults"
    static private let defaults = UserDefaults.init(suiteName: suiteName)
    
    public class func getSetting(_ key: SettingKeys) -> Any? {
        if defaults != nil {
            return defaults!.object(forKey: key.rawValue)
        }
        return nil
    }
    
    public class func setSetting(_ setting: Any?, forKey key: SettingKeys) -> Bool {
        if let settingString = setting as? String {
//            if validator[key]!(settingString) {
                if defaults != nil {
                    defaults!.set(settingString, forKey: key.rawValue)
                    defaults!.synchronize()
                    return true
                }
//            }
        }
        return false
    }
    
}
