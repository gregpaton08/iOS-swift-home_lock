//
//  LockBodyView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 12/4/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockBodyView: UIView {
    
    // Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setup() {
        backgroundColor = UIColor.clear
    }
    
    // MARK: API
    
    public var lockColor = UIColor.black
    
    // MARK: - Draw

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        lockColor.setFill()
        path.lineWidth = 1.0

        // Draw the lock body.
        let lockBodyPath = UIBezierPath(roundedRect: CGRect(origin: self.bounds.origin, size: self.bounds.size), cornerRadius: 3.0)
        lockBodyPath.fill()
    }

}
