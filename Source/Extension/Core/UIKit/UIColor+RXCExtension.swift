//
//  UIColor+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public extension UIColor {

    static func random()-> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }

    static func initWith(red:Int, green:Int, blue:Int, alpha:CGFloat=1.0)->UIColor {
        let r = CGFloat(red)/CGFloat(255)
        let g = CGFloat(green)/CGFloat(255)
        let b = CGFloat(blue)/CGFloat(255)
        let color = UIColor(red: r, green: g, blue: b, alpha: alpha)
        return color
    }

    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var formatted = hex.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
}
