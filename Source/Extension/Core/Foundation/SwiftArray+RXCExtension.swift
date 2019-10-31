//
//  SwiftArray+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension Array {

    func safeGet(index: Int) -> Element? {
        if index < 0 || index >= self.count {
            return nil
        }
        return self[index]
    }

    mutating func appendOptional(_ element: Element?) {
        if element != nil {
            self.append(element!)
        }
    }

    subscript(range: CountableClosedRange<Int>) -> [Element] {
        var arr: [Element] = []
        for i in range {
            arr.append(self[i])
        }
        return arr
    }

    @discardableResult
    func maxNum(_ num:Int) -> [Element] {
        if self.count > num {
            return Array(self[0..<num])
        }
        return self
    }

}
