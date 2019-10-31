//
//  NSArray+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension NSArray {

    func safeGet(index: Int) -> Element? {
        if index < 0 || index >= self.count {
            return nil
        }
        return self[index]
    }

    subscript(sub: CountableClosedRange<Int>) -> [Element] {
        var arr: [Element] = []
        for i in sub {
            arr.append(self[i])
        }
        return arr
    }

    var isEmpty:Bool {
        return self.count == 0
    }

}
