//
//  UIResponder+RXCExtension.swift
//  ruixingchen
//
//  Created by ruixingchen on 6/7/18.
//  Copyright © 2018 CoolApk. All rights reserved.
//

import UIKit

public extension UIResponder {

    ///传入一个根Responder, 之后可以一直追溯next
    class RXCResponderChainEnumerator: Sequence {

        public typealias Element = UIResponder
        public typealias Iterator = AnyIterator<UIResponder>

        private var root:UIResponder?

        public init(root:UIResponder) {
            self.root = root
        }

        public func makeIterator() -> AnyIterator<UIResponder> {
            var current:UIResponder? = self.root
            return AnyIterator {
                current = current?.next
                return current
            }
        }

    }

    /// 在Next链中寻找匹配的目标
    ///
    /// - Parameters:
    ///   - deepLimit: 深度限制, 自己的深度为0, next的深度为1
    func findInNextResponderChain(reversed:Bool=true, match:(UIResponder)->Bool)->UIResponder? {
        let chainEnumerator = RXCResponderChainEnumerator(root: self)
        if reversed {
            for i in chainEnumerator {
                if match(i) {
                    return i
                }
            }
        }else {
            for i in chainEnumerator.reversed() {
                if match(i) {
                    return i
                }
            }
        }
        return nil
    }

    func farestViewController() -> UIViewController? {
        return self.findInNextResponderChain(reversed: true, match: {$0 is UIViewController}) as? UIViewController
    }

    func closestViewController(includeSelf: Bool=true) -> UIViewController? {
        return self.findInNextResponderChain(reversed: false, match: {$0 is UIViewController}) as? UIViewController
    }

    func closestNavigationController(includeSelf: Bool=true) -> UINavigationController? {
        return self.findInNextResponderChain(reversed: false, match: {$0 is UINavigationController}) as? UINavigationController
    }

}
