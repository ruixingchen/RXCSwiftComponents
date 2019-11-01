//
//  CGRect+Extension.swift
//  SampleProject
//
//  Created by ruixingchen on 1/23/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import CoreGraphics

public extension CGRect {

    var leftTopOrigin:CGPoint {
        get {
            return CGPoint(x: self.origin.x, y: self.origin.y)
        }
        set {
            self.origin = newValue
        }
    }

    var rightTopOrigin:CGPoint {
        get {
            return CGPoint(x: self.origin.x+self.size.width, y: self.origin.y)
        }
        set {
            self.origin = CGPoint(x: newValue.x-self.size.width, y: newValue.y)
        }
    }

    var leftBottomOrigin:CGPoint {
        get {
            return CGPoint(x: self.origin.x, y: self.origin.y+self.size.height)
        }
        set {
            self.origin = CGPoint(x: newValue.x, y: newValue.y-self.size.height)
        }
    }

    var rightBottomOrigin:CGPoint {
        get {
            return CGPoint(x: self.origin.x+self.size.width, y: self.origin.y+self.size.height)
        }
        set {
            self.origin = CGPoint(x: newValue.x-self.size.width, y: newValue.y-self.size.height)
        }
    }
    
}
