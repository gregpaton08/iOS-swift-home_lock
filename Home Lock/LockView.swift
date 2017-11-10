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
        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        UIColor.black.setStroke()
        UIColor.black.setFill()
        path.lineWidth = 5.0
        path.stroke()
    }
}
