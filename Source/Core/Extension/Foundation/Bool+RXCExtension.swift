//
//  Bool+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/17/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Bool {

    ///随机生成Bool值
    ///
    /// - Parameter rate: 生成true的几率
    static func random(_ rate:CGFloat)->Bool{
        return CGFloat.random(in: 0..<1) < rate
    }

}
