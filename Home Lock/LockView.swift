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
    
    public var isLocked: Bool {
        get {
            return lockShackleView.isLocked
        }
        set {
            lockShackleView.frame.origin.x = lockViewRect.origin.x + (newValue ? 0 : pointsFrom(units: 4))
//            lockShackleView.transform = lockShackleView.transform.scaledBy(x: 5, y: 5)
//            lockShackleView.transform = lockShackleView.transform.rotated(by: CGFloat.pi)
            lockShackleView.isLocked = newValue
//            if newValue != lockShackleView.isLocked {
//                UIView.transition(with: lockShackleView, duration: 1.0, options: [.transitionFlipFromRight], animations: {
//                    self.lockShackleView.isLocked = newValue
//                }, completion: nil)
//            }
        }
    }
    
    private lazy var lockShackleView: LockShackleView = createLockShackleView()
    
    private func createLockShackleView() -> LockShackleView {
        let shackle = LockShackleView()
        shackle.backgroundColor = UIColor.clear
        addSubview(shackle)
        return shackle
    }
    
    private let lockViewAspectRatio = CGSize(width: 16.0, height: 10.0)
    private var lockViewRect = CGRect()
    
    // The lock dimensions are conceptualized as "units" so that the lock can be generically drawn given any view size. For reference, the total size required by the lock view is 16 units wide and 10 units high. The lock body is 8 units wide and 6 units tall. Since the lock view size is 10 units in height, we can convert from units to actual points by multiply the height by the number of units and dividing by 10.
    private func pointsFrom(units: CGFloat) -> CGFloat {
        return lockViewRect.size.height * units / 10.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Find the largest size that will fit within the bounds given the aspect ratio.
        var lockViewSize: CGSize
        if self.bounds.width * lockViewAspectRatio.height < self.bounds.height * lockViewAspectRatio.width {
            lockViewSize = CGSize(width: self.bounds.width, height: self.bounds.width * lockViewAspectRatio.height / lockViewAspectRatio.width)
        } else {
            lockViewSize = CGSize(width: self.bounds.height * lockViewAspectRatio.width / lockViewAspectRatio.height, height: self.bounds.height)
        }
        
        lockViewRect.origin = CGPoint(x: (self.bounds.width - lockViewSize.width) / 2, y: (self.bounds.height - lockViewSize.height) / 2)
        lockViewRect.size = lockViewSize
        
        lockShackleView.frame = lockViewRect
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        UIColor.black.setStroke()
        UIColor.black.setFill()
        path.lineWidth = 1.0
        
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    
        // Draw the lock body.
        let lockBodySize = CGSize(width: pointsFrom(units: 8), height: pointsFrom(units: 6))
        let lockBodyOrigin = CGPoint(x: center.x - pointsFrom(units: 4), y: center.y - pointsFrom(units: 1))
        let lockBodyPath = UIBezierPath(roundedRect: CGRect(origin: lockBodyOrigin, size: lockBodySize), cornerRadius: 1.0)
        lockBodyPath.stroke()
        
        // Draw the lock shackle.
//        var lockShackleCenter: CGPoint
//        if isLocked {
//            lockShackleCenter = CGPoint(x: center.x, y: center.y - pointsFrom(units: 2.5))
//        } else {
//            lockShackleCenter = CGPoint(x: center.x + pointsFrom(units: 5), y: center.y - pointsFrom(units: 2.5))
//        }
//        let lockShackleOuterEdgeRadius = pointsFrom(units: 2.5)
//        let lockShackleOuterEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
//        let lockShackleOuterEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleOuterEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
//        let lockShackleInnerEdgeRadius = pointsFrom(units: 1.5)
//        let lockShackleInnerEdgeStart = CGPoint(x: lockShackleCenter.x - lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
//        let lockShackleInnerEdgeEnd = CGPoint(x: lockShackleCenter.x + lockShackleInnerEdgeRadius, y: lockShackleCenter.y + pointsFrom(units: 1.5))
//        path.move(to: lockShackleOuterEdgeStart)
//        path.addArc(withCenter: lockShackleCenter, radius: lockShackleOuterEdgeRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
//        path.addLine(to: lockShackleOuterEdgeEnd)
//        path.addLine(to: lockShackleInnerEdgeEnd)
//        path.addArc(withCenter: lockShackleCenter, radius: lockShackleInnerEdgeRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
//        path.addLine(to: lockShackleInnerEdgeStart)
//        path.close()
//        path.stroke()
    }
}
