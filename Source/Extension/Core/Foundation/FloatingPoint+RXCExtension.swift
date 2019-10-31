//
//  FloatingPoint+RXCExtension.swift
//  SampleProject
//
//  Created by ruixingchen on 2/9/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
import CoreGraphics

public extension BinaryFloatingPoint {

    var string:String {
        return "\(self)"
    }

    var abs:Self {
        if self < 0 {
            return -self
        }
        return self
    }

    var int:Int {
        return Int(self)
    }

    var cgfloat:CGFloat {
        return CGFloat(self)
    }

    var double:Double {
        return Double(self)
    }

}
