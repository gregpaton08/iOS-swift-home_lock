//
//  LockDisableView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 12/4/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

class LockDisableView: UIView {
    
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
    
    public var crossColor = UIColor.black

    override func draw(_ rect: CGRect) {
        crossColor.setFill()
        
        // Draw a cross in center of lock body.
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let minimumDimension = min(self.bounds.width, self.bounds.height)
        let barSize = CGSize(width: minimumDimension, height: minimumDimension / 6)
        let barOrigin = CGPoint(x: center.x - (barSize.width / 2), y: self.bounds.origin.y + (self.bounds.height / 2) - (barSize.height / 2))
        let barPath = UIBezierPath(roundedRect: CGRect(origin: barOrigin, size: barSize), cornerRadius: 0)
        barPath.apply(CGAffineTransform(translationX: self.bounds.origin.x - center.x, y: self.bounds.origin.y - center.y))
        barPath.apply(CGAffineTransform(rotationAngle: CGFloat.pi / 4))
        barPath.apply(CGAffineTransform(translationX: center.x - self.bounds.origin.x, y: center.y - self.bounds.origin.y))
        barPath.fill()
        barPath.apply(CGAffineTransform(translationX: self.bounds.origin.x - center.x, y: self.bounds.origin.y - center.y))
        barPath.apply(CGAffineTransform(rotationAngle: CGFloat.pi / 2))
        barPath.apply(CGAffineTransform(translationX: center.x - self.bounds.origin.x, y: center.y - self.bounds.origin.y))
        barPath.fill()
    }

}
