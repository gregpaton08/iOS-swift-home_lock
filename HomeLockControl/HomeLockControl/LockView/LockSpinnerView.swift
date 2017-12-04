//
//  LockSpinnerView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 11/13/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockSpinnerView: UIView {
    
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
        isHidden = true
        backgroundColor = UIColor.clear
    }
    
    // MARK: - API
    
    var spinnerColor = UIColor.white
    
    var isSpinning = false {
        didSet {
            if isSpinning {
                rotate()
            }
        }
    }
    
    private func rotate() {
        isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }, completion: { finished in
            if finished && self.isSpinning {
                self.rotate()
            } else if finished {
                self.isHidden = true
            }
        })
    }
    
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
