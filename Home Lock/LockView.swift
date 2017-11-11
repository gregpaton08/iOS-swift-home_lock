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
        let radius: CGFloat = 11.0
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let dimension = min(self.bounds.width, self.bounds.height)
//        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        
        let lockHeight = dimension
        let lockWidth = dimension * 8 / 10
        
        let lockBodyCenter = CGPoint(x: center.x, y: center.y + (self.bounds.height / 5))
        let lockBodyWidth = dimension * 8 / 10
        let lockBodyHeight = dimension * 6 / 10
        
        path.move(to: CGPoint(x: lockBodyCenter.x - (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x - (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y + (lockBodyHeight / 2)))
        path.addLine(to: CGPoint(x: lockBodyCenter.x + (lockBodyWidth / 2), y: lockBodyCenter.y - (lockBodyHeight / 2)))
        path.close()

        UIColor.black.setStroke()
        UIColor.black.setFill()
        path.lineWidth = 1.0
        path.stroke()
//        path.fill()
        
//        path.move(to: CGPoint(x: center.x - (dimension * 3 / 10), y: center.y + (dimension / 10)))
        path.addArc(withCenter: CGPoint(x: center.x, y: center.y - (dimension / 10)), radius: dimension * 2.5 / 10, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        path.addArc(withCenter: CGPoint(x: center.x, y: center.y - (dimension / 10)), radius: dimension * 1.5 / 10, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        
        path.stroke()
//        path.fill()
        
    }
}
