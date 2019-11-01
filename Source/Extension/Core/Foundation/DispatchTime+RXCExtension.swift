//
//  DispatchTime+FromNow.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension DispatchTime {

    static func fromNow(nanoseconds:Int)->DispatchTime{
        return DispatchTime.now()+DispatchTimeInterval.nanoseconds(nanoseconds)
    }

    static func fromNow(microseconds:Int)->DispatchTime{
        return DispatchTime.now()+DispatchTimeInterval.microseconds(microseconds)
    }

    static func fromNow(milliseconds:Int)->DispatchTime{
        return DispatchTime.now()+DispatchTimeInterval.milliseconds(milliseconds)
    }

    static func fromNow(seconds:Int)->DispatchTime{
        return DispatchTime.now()+DispatchTimeInterval.seconds(seconds)
    }

}
