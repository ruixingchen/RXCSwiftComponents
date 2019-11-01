//
//  NSRange+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 10/14/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public extension NSRange {

    ///根据开始和结束的位置计算Range, 注意, 如果开始和结束相等, 那么length是1
    init(location:Int, endLocation:Int) {
        self.init(location: location, length: endLocation-location+1)
    }

    static var zero:NSRange {
        return NSRange(location: 0, length: 0)
    }

    ///是否是0位置0长度
    var isZero:Bool {return self.location == 0 && self.length == 0}

    func toRange()->Range<Int> {
        return self.location..<self.location+self.length
    }

    func toClosedRange()->ClosedRange<Int> {
        return self.location...self.location+self.length-1
    }

}
