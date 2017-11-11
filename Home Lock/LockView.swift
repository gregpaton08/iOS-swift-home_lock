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
        
        let radius: CGFloat = 11.0
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let dimension = min(self.bounds.width, self.bounds.height)
//        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        
        let lockHeight = dimension
        let lockWidth = dimension * 8 / 10
        
        let lockBodyCenter = CGPoint(x: center.x, y: center.y + (self.bounds.height / 5))
        let lockBodyWidth = dimension * 8 / 10
        let lockBodyHeight = dimension * 6 / 10
        
        let lockShackleCenter = CGPoint(x: center.x, y: center.y - (dimension * 2.5 / 10))
        let lockShackleOuterEdgeRadius = dimension * 2.5 / 10
        let lockShackleOuterEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleOuterEdgeRadius, y: lockShackleCenter.y + (dimension * 1.5 / 10))
        let lockShackleOuterEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleOuterEdgeRadius, y: lockShackleCenter.y + (dimension * 1.5 / 10))
        let lockShackleInnerEdgeRadius = dimension * 1.5 / 10
        let lockShackleInnerEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleInnerEdgeRadius, y: lockShackleCenter.y + (dimension * 1.5 / 10))
        let lockShackleInnerEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleInnerEdgeRadius, y: lockShackleCenter.y + (dimension * 1.5 / 10))
        
        // Start drawing path.
        
        // draw the lock body.
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
        
        
//        path.addLine(to: lockShackleOuterEdgeStart)
//        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
//        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
//        path.close()
        
//        path.addArc(withCenter: lockShackleCenter, radius: dimension * 2.5 / 10, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
//
//        path.addLine(to: lockShackleOuterEdgeEnd)
//
//        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
//        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
//        path.close()
////        path.addLine(to: CGPoint(x: lockBodyCenter.x - (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
//
//        path.stroke()
//
//        path.move(to: lockShackleInnerEdgeStart)
//        path.addArc(withCenter: lockShackleCenter, radius: lockShackleInnerEdgeRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
//        path.addLine(to: lockShackleInnerEdgeEnd)
//        path.close()
//
//        path.stroke()
    }
}
