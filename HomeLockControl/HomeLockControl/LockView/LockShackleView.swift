//
//  LockShackleView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 11/13/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockShackleView: UIView {
    
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
    
    // MARK: - API
    
    public var isLocked = true
    public var lockColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        lockColor.setFill()
        path.lineWidth = 1.0
        
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        var lockViewSize = self.bounds.size
        
        // The lock dimensions are conceptualized as "units" so that the lock can be generically drawn given any view size. For reference, the total size required by the lock view is 16 units wide and 10 units high. The lock body is 8 units wide and 6 units tall. Since the lock view size is 10 units in height, we can convert from units to actual points by multiply the height by the number of units and dividing by 10.
        func pointsFrom(units: CGFloat) -> CGFloat {
            return lockViewSize.height * units / 10.0
        }
        
        // Draw the lock shackle.
        var lockShackleCenter: CGPoint
        if isLocked {
            lockShackleCenter = CGPoint(x: center.x, y: center.y - pointsFrom(units: 2.5))
        } else {
            lockShackleCenter = CGPoint(x: center.x + pointsFrom(units: 5), y: center.y - pointsFrom(units: 2.5))
        }
        let lockShackleOuterEdgeRadius = pointsFrom(units: 2.5)
        let lockShackleOuterEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleOuterEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleInnerEdgeRadius = pointsFrom(units: 1.5)
        let lockShackleInnerEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleInnerEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        path.move(to: lockShackleOuterEdgeStart)
        path.addArc(withCenter: lockShackleCenter, radius: lockShackleOuterEdgeRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        path.addLine(to: lockShackleOuterEdgeEnd)
        path.addLine(to: lockShackleInnerEdgeEnd)
        path.addArc(withCenter: lockShackleCenter, radius: lockShackleInnerEdgeRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        path.addLine(to: lockShackleInnerEdgeStart)
        path.close()
        path.fill()
    }
}

