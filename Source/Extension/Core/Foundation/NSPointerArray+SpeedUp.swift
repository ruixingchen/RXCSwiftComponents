//
//  NSPointerArray+SpeedUp.swift
//  RXCPageViewController
//
//  Created by ruixingchen on 12/7/18.
//  Copyright © 2018 ruixingchen. All rights reserved.
//

import Foundation

public extension NSPointerArray {

    private func pointerConvert(_ object:AnyObject)->UnsafeMutableRawPointer{
        return Unmanaged.passUnretained(object).toOpaque()
    }

    //MARK: - C

    func add(_ object:AnyObject?){
        if object == nil {
            self.addPointer(nil)
            return
        }
        let pointer:UnsafeMutableRawPointer = pointerConvert(object!)
        self.addPointer(pointer)
    }

    func insert(_ object:AnyObject?, at index:Int){
        if object == nil {
            self.insertPointer(nil, at: index)
            return
        }
        let pointer:UnsafeMutableRawPointer = pointerConvert(object!)
        insertPointer(pointer, at: index)
    }

    //MARK: - R

    func object(at index:Int) ->AnyObject? {
        guard let pointer:UnsafeMutableRawPointer = self.pointer(at: index) else {return nil}
        return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
    }

    func safeObject(at index:Int) ->AnyObject? {
        if index < 0 || index >= self.count {return nil}
        guard let pointer:UnsafeMutableRawPointer = self.pointer(at: index) else {return nil}
        return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
    }

    var first:AnyObject? {
        if self.count == 0 {return nil}
        return self.object(at: 0)
    }

    var last:AnyObject? {
        if self.count == 0 {return nil}
        return self.object(at: self.count-1)
    }

    //MARK: - U

    func replace(at index:Int, withObject object:AnyObject?) {
        if object == nil {
            self.replacePointer(at: index, withPointer: nil)
            return
        }
        let pointer:UnsafeMutableRawPointer = pointerConvert(object!)
        replacePointer(at: index, withPointer: pointer)
    }

    //MARK: - D

    ///remove first match
    func removeFirst(_ object:AnyObject?){
        if object == nil {
            self.rxc_compact()
        }else{
            let pointer:UnsafeMutableRawPointer = pointerConvert(object!)
            let count:Int = self.count
            for i in 0..<count {
                if self.pointer(at: i) == pointer {
                    self.removePointer(at: i)
                    break
                }
            }
        }
    }

    ///remove all match
    func removeAll(_ object:AnyObject?){
        if object == nil {
            self.rxc_compact()
        }else{
            let pointer:UnsafeMutableRawPointer = pointerConvert(object!)
            let count:Int = self.count
            for i in 0..<count {
                //reversed
                let index:Int = count-i-1
                if self.pointer(at: index) == pointer {
                    self.removePointer(at: i)
                }
            }
        }
    }

    ///compact that really works
    func rxc_compact(){
        //to solve the bug of NSPointerArray
        self.addPointer(nil)
        self.compact()

//        let count:Int = self.count
//        for i in 0..<count {
//            let index:Int = count-i-1
//            if self.pointer(at: index) == nil {
//                self.removePointer(at: index)
//            }
//        }
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
