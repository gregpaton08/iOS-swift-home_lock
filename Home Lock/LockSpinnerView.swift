//
//  LockSpinnerView.swift
//  Home Lock
//
//  Created by Greg Paton on 11/11/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockSpinnerView: UIView {

    var spinnerColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 2.0
        spinnerColor.setStroke()
        
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let radius = (min(self.bounds.width, self.bounds.height) / 2) - 1
        path.addArc(withCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 3, clockwise: false)
        path.stroke()
    }

}
