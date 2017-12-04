//
//  LockDisableView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 12/4/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockDisableView: UIView {

    override func draw(_ rect: CGRect) {
        UIColor.green.setFill()
        
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let minimumDimension = min(self.bounds.width, self.bounds.height)
        let horizontalSize = CGSize(width: minimumDimension, height: minimumDimension / 6)
        let horizontalOrigin = CGPoint(x: center.x - (horizontalSize.width / 2), y: self.bounds.origin.y + (self.bounds.height / 2) - (horizontalSize.height / 2))
        let horizontalPath = UIBezierPath(roundedRect: CGRect(origin: horizontalOrigin, size: horizontalSize), cornerRadius: 0)
        horizontalPath.apply(CGAffineTransform(translationX: self.bounds.origin.x - center.x, y: self.bounds.origin.y - center.y))
        horizontalPath.apply(CGAffineTransform(rotationAngle: CGFloat.pi / 4))
        horizontalPath.apply(CGAffineTransform(translationX: center.x - self.bounds.origin.x, y: center.y - self.bounds.origin.y))
//        horizontalPath.apply(CGAffineTransform(translationX: -center.x, y: -center.y))
        horizontalPath.fill()
        horizontalPath.apply(CGAffineTransform(translationX: self.bounds.origin.x - center.x, y: self.bounds.origin.y - center.y))
        horizontalPath.apply(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
        horizontalPath.apply(CGAffineTransform(translationX: center.x - self.bounds.origin.x, y: center.y - self.bounds.origin.y))
        horizontalPath.fill()
    }

}
