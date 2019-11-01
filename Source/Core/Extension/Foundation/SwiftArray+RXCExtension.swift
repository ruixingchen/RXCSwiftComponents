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

    @discardableResult
    mutating func appendOptional(_ element: Element?)->Bool {
        if element != nil {
            self.append(element!)
            return true
        }else {
            return false
        }
    }

    subscript(range: CountableClosedRange<Index>) -> [Element] {
        let low = self.index(self.startIndex, offsetBy: range.lowerBound)
        let up = self.index(self.startIndex, offsetBy: range.upperBound)
        return [Element].init(self[low..<up])
    }

    ///限制数量, 将超过的部分删除, 返回
    func limitingCount(_ max:Int) -> [Element] {
        if self.count > max {
            return [Element].init(self[0..<max])
        }else {
            return self
        }
    }
    
    mutating func limittedCount(_ max:Int) {
        if self.count > max {
            self = [Element].init(self[0..<max])
        }
    }

}
