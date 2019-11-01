//
//  RXCMutableArray.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/2/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

///Swift的Array是不可变的结构, 真的烦, 写一个可变的Array, 方便操作
public final class RXCMutableArray<Container:RangeReplaceableCollection>: MutableCollection, RangeReplaceableCollection where Container.Index == Int {

    public typealias Element = Container.Element
    public typealias Index = Container.Index

    fileprivate var container:Container

    private let queue:DispatchQueue = DispatchQueue(label: "queue", qos: .default, attributes: .concurrent)

    private func sync(closure:@escaping ()->Void) {
        self.queue.async(group: nil, qos: .default, flags: .barrier) {
            closure()
        }
    }

    private func async(closure:()->Void) {
        self.queue.sync {
            closure()
        }
    }

    public init() {
        self.container = Container.init()
    }

    public init<S>(_ s: S) where Element == S.Element, S : Sequence {
        self.container = Container.init(s)
    }

    public init(repeating repeatedValue: Element, count: Int) {
        self.container = Container.init(repeating: repeatedValue, count: count)
    }

    public var isEmpty: Bool {return self.container.isEmpty}

    public var count: Int {return self.container.count}

    public var underestimatedCount: Int {return self.container.underestimatedCount}

    public var first: Container.Element? {return self.container.first}

    var last:Element? {
        var result:Element?
        self.sync {
            if !self.isEmpty {
                result = self.container[self.container.count-1]
            }
        }
        return result
    }

    //MARK: - Collection

    public var startIndex: Container.Index {return self.container.startIndex}

    public var endIndex: Container.Index {return self.container.endIndex}

    public subscript(position: Container.Index) -> Container.Element {
        get {
            var result:Element!
            self.async {
                result = self.container[position]
            }
            return result
        }
        set {
            self.sync {
                self.container.replaceSubrange(position..<(position+1), with: CollectionOfOne(newValue))
            }
        }
    }

    public subscript(bounds: Range<Int>) -> [Element] {
        get {
            var result:[Element]!
            self.async {
                result = [Element].init(self.container[bounds])
            }
            return result
        }
        set {
            self.sync {
                self.container.replaceSubrange(bounds, with: newValue)
            }
        }
    }

    public subscript<R>(r: R) -> [Element] where R : RangeExpression, Index == R.Bound {
        get {
            var result:[Element]!
            self.async {
                result = [Element].init(self.container[r])
            }
            return result
        }
        set {
            self.sync {
                self.container.replaceSubrange(r, with: newValue)
            }
        }
    }

    public func randomElement() -> Element? {
        var result:Element?
        self.async {
            result = self.container.randomElement()
        }
        return result
    }

    public func randomElement<T>(using generator: inout T) -> Element? where T : RandomNumberGenerator {
        return self.container.randomElement(using: &generator)
    }

    public func index(after i: Container.Index) -> Container.Index {
        var result:Container.Index!
        self.async {
            result = self.container.index(after: i)
        }
        return result
    }

    public func index(_ i: Container.Index, offsetBy distance: Int) -> Container.Index {
        var result:Container.Index!
        self.async {
            result = self.container.index(i, offsetBy: distance)
        }
        return result
    }

    public func index(_ i: Container.Index, offsetBy distance: Int, limitedBy limit: Container.Index) -> Container.Index? {
        var result:Container.Index!
        self.async {
            result = self.container.index(i, offsetBy: distance, limitedBy: limit)
        }
        return result
    }

    //MARK: - Adding Elements

    public func add(_ element:Element) {
        self.sync {
            self.container.append(element)
        }
    }

    public func insert(_ newElement: Element, at i: Int) {
        self.sync {
            self.container.insert(newElement, at: i)
        }
    }

    public func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, Element == C.Element {
        self.sync {
            self.container.insert(contentsOf: newElements, at: i)
        }
    }

    public func replaceSubrange<C>(_ subrange: Range<Container.Index>, with newElements: __owned C) where C : Collection, Element == C.Element {
        self.sync {
            self.container.replaceSubrange(subrange, with: newElements)
        }
    }

    public func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Element == C.Element, Index == R.Bound {
        self.sync {
            self.container.replaceSubrange(subrange, with: newElements)
        }
    }

    public func reserveCapacity(_ minimumCapacity: Int) {
        self.sync {
            self.container.reserveCapacity(minimumCapacity)
        }
    }

    //MARK: - Combining Arrays

    public func add<S>(contentsOf newElements: S) where Element == S.Element, S : Sequence {
        self.sync {
            self.container.append(contentsOf: newElements)
        }
    }

    static func + <Other>(lhs: Other, rhs: RXCMutableArray<Element>) -> RXCMutableArray<Element> where Other : Sequence, Element == Other.Element {

    }

}
