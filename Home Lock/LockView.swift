//
//  LockView.swift
//  Home Lock
//
//  Created by Greg Paton on 11/10/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

@IBDesignable
class LockView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Draw the checkbox border.
        let path = UIBezierPath()
        UIColor.black.setStroke()
        UIColor.black.setFill()
        path.lineWidth = 1.0
        
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let lockViewAspectRatio = CGSize(width: 16.0, height: 10.0)
        var lockViewSize: CGSize
        if self.bounds.width * lockViewAspectRatio.height < self.bounds.height * lockViewAspectRatio.width {
            lockViewSize = CGSize(width: self.bounds.width, height: self.bounds.width * lockViewAspectRatio.width / lockViewAspectRatio.height)
        } else {
            lockViewSize = CGSize(width: self.bounds.height * lockViewAspectRatio.width / lockViewAspectRatio.height, height: self.bounds.height)
        }
        
        // The lock dimensions are conceptualized as "units" so that the lock can be generically drawn given any view size. For reference, the total size required by the lock view is 16 units wide and 10 units high. The lock body is 8 units wide and 6 units tall. Since the lock view size is 10 units in height, we can convert from units to actual points by multiply the height by the number of units and dividing by 10.
        func pointsFrom(units: CGFloat) -> CGFloat {
            return lockViewSize.height * units / 10.0
        }
        
        let lockBodyCenter = CGPoint(x: center.x, y: center.y + (self.bounds.height / 5))
        let lockBodyWidth = lockViewSize.height * 8 / 10
        let lockBodyHeight = lockViewSize.height * 6 / 10
        
        let lockShackleCenter = CGPoint(x: center.x, y: center.y - pointsFrom(units: 2.5))
        let lockShackleOuterEdgeRadius = lockViewSize.height * 2.5 / 10
        let lockShackleOuterEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleOuterEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleInnerEdgeRadius = pointsFrom(units: 1.5)
        let lockShackleInnerEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        let lockShackleInnerEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
        
        // Start drawing path.
        
        // Draw the lock body.
        path.move(to: CGPoint(x: lockBodyCenter.x - (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x - (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
        path.close()
        path.stroke()
        
        // Draw the lock shackle.
        path.move(to: lockShackleOuterEdgeStart)
        path.addArc(withCenter: lockShackleCenter, radius: lockShackleOuterEdgeRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        path.addLine(to: lockShackleOuterEdgeEnd)
        path.addLine(to: lockShackleInnerEdgeEnd)
        path.addArc(withCenter: lockShackleCenter, radius: lockShackleInnerEdgeRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        path.addLine(to: lockShackleInnerEdgeStart)
        path.close()
        path.stroke()
    }
}
