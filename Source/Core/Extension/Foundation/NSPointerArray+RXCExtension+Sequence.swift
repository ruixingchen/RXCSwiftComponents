//
//  NSPointerArray+Sequence.swift
//  RXCPageViewController
//
//  Created by ruixingchen on 12/7/18.
//  Copyright © 2018 ruixingchen. All rights reserved.
//

import Foundation
/*
extension NSPointerArray: Sequence {

    public func makeIterator() -> NSPointerArray.RXCIterator {
        return RXCIterator(array: self)
    }

}

public extension NSPointerArray {

    class RXCIterator: IteratorProtocol {
        public typealias Element = AnyObject

        let array:NSPointerArray

        init(array:NSPointerArray) {
            self.array = array
        }

        var nextIndex:Int = 0
        public func next() -> NSPointerArray.Iterator.Element? {
            var next:AnyObject? = self.array.safeObject(at: nextIndex)
            while next == nil && nextIndex < self.array.count {
                nextIndex += 1
                next = self.array.safeObject(at: nextIndex)
            }
            nextIndex += 1
            return next
        }

    }

}
*/
