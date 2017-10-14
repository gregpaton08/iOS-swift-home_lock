//
//  HomeLock.swift
//  Home Lock
//
//  Created by Greg Paton on 10/14/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import Foundation

public class HomeLock {
    
    public var serverAddress = ""
    public var serverPort = ""
    
    public init() {
        
    }
    
    public var statusRequestState: URLSessionTask.State {
        get {
            return lockStatusGetDataTask?.state ?? .completed
        }
    }
    
    public func cancelStatusRequest() {
        lockStatusGetDataTask?.cancel()
    }
    
    private let lockStatusSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 3
        return URLSession.init(configuration: config)
    }()
    private var lockStatusGetDataTask: URLSessionDataTask?
    
    private func getLockStatusUrl() -> URL? {
        return URL(string: "http://" + serverAddress + ":" + serverPort + "/api/v1/lock_status")
    }
    
    public func getStatus(_ callbackFunction: @escaping (Bool?, Error?) -> Void) {
        // If the request is already in progress then don't request again.
        if lockStatusGetDataTask?.state == .running {
            return
        }
        
        lockStatusGetDataTask = lockStatusSession.dataTask(with: getLockStatusUrl()!) { (data, response, error) in
            var lockStatus: Bool?
            if error == nil {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [String: Any] {
                    lockStatus = dictionary["status"] as? Bool
                }
            }
            callbackFunction(lockStatus, error)
        }
        
        lockStatusGetDataTask?.resume()
    }
    
    public func lockDoor(_ status: Bool, callback completionHandler: @escaping () -> Void) {
        let dataString = status ? "{\"status\":true}" : "{\"status\":false}"
        
        // Create a PUT request.
        var request = URLRequest(url: getLockStatusUrl()!)
        request.httpMethod = "PUT"
        request.timeoutInterval = 3.0
        
        // Add the JSON data to the request.
        let jsonData = dataString.data(using: String.Encoding.utf8)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(describing: jsonData?.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionHandler()
        }
        
        task.resume()
    }
}
