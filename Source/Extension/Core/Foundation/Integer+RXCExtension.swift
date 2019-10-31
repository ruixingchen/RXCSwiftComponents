//
//  Int+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
import CoreGraphics

public extension BinaryInteger {

    var string:String {return self.description}

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

public extension SignedInteger {

    var abs:Self {
        if self < 0 {return -self}
        return self
    }

}

public extension Int {



}
