//
//  TimeInterval.swift
//  SampleProject
//
//  Created by ruixingchen on 3/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension TimeInterval {

    static var now:TimeInterval {
        return Date().timeIntervalSince1970
    }

    static var intNow:Int64 {
        return Int64(now)
    }

}
