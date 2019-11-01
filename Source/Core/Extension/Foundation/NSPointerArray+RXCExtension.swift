//
//  NSPointerArray+RXCExtension.swift
//  RXCPageViewController
//
//  Created by ruixingchen on 12/7/18.
//  Copyright © 2018 ruixingchen. All rights reserved.
//

import Foundation

public extension UnsafeMutableRawPointer {

    static func from(object:AnyObject)->UnsafeMutableRawPointer {
        return Unmanaged.passUnretained(object).toOpaque()
    }

    func unbox<T:AnyObject>()->T {
        return Unmanaged<T>.fromOpaque(self).takeUnretainedValue()
    }

}

public extension NSPointerArray {

    private func lock() {
        objc_sync_enter(self)
    }

    private func unlock() {
        objc_sync_exit(self)
    }

    //MARK: - C

    func add(_ object:AnyObject?){
        if let valid = object {
            let pointer:UnsafeMutableRawPointer = UnsafeMutableRawPointer.from(object: valid)
            self.addPointer(pointer)
        }else {
            self.addPointer(nil)
        }
    }

    func insert(_ object:AnyObject?, at index:Int){
        if let valid = object {
            let pointer:UnsafeMutableRawPointer = UnsafeMutableRawPointer.from(object: valid)
            self.insertPointer(pointer, at: index)
        }else {
            self.insertPointer(nil, at: index)
        }
    }

    //MARK: - R

    func object<T:AnyObject>(at index:Int) ->T? {
        guard let pointer:UnsafeMutableRawPointer = self.pointer(at: index) else {return nil}
        return pointer.unbox()
    }

    func safeObject<T:AnyObject>(at index:Int) ->T? {
        self.lock()
        defer {self.unlock()}
        if index < 0 || index >= self.count {return nil}
        guard let pointer:UnsafeMutableRawPointer = self.pointer(at: index) else {return nil}
        return pointer.unbox()
    }

    var first:AnyObject? {
        self.lock()
        defer {self.unlock()}

        if self.count == 0 {return nil}
        return self.safeObject(at: 0)
    }

    var last:AnyObject? {
        if self.count == 0 {return nil}
        return self.safeObject(at: self.count-1)
    }

    //MARK: - U

    func replace(at index:Int, withObject object:AnyObject?) {
        if let valid = object {
            let pointer = UnsafeMutableRawPointer.from(object: valid)
            self.replacePointer(at: index, withPointer: pointer)
        }else {
            self.replacePointer(at: index, withPointer: nil)
        }
    }

    //MARK: - D

    ///remove first match
    func removeFirst(_ object:AnyObject?){
        if let valid = object {
            let pointer:UnsafeMutableRawPointer = UnsafeMutableRawPointer.from(object: valid)
            let count:Int = self.count
            for i in (0..<count).reversed() {
                if self.pointer(at: i) == pointer {
                    self.removePointer(at: i)
                    return
                }
            }
        }else {
            self.rxc_compact()
        }
    }

    ///remove all match
    func removeAll(_ object:AnyObject?){
        if let valid = object {
            let pointer:UnsafeMutableRawPointer = UnsafeMutableRawPointer.from(object: valid)
            let count:Int = self.count
            for i in (0..<count).reversed() {
                if self.pointer(at: i) == pointer {
                    self.removePointer(at: i)
                }
            }
        }else {
            self.rxc_compact()
        }
    }

    ///compact that really works
    func rxc_compact(){
        //to solve the bug of NSPointerArray
        self.addPointer(nil)
        self.compact()
    }

    subscript(index:Int)->AnyObject? {
        get {
            return self.object(at: index)
        }
        set {
            self.replace(at: index, withObject: newValue)
        }
    }
}
