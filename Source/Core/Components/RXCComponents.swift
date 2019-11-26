//
//  RXCComponents.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public struct RXCComponents {

    @available(iOS 8.0, *)
    public static func isSystemAtLeast(_ major:Int, _ minor:Int, _ patch:Int)->Bool {
        let currentInfo = ProcessInfo.processInfo
        let matched = currentInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: major, minorVersion: minor, patchVersion: patch))
        return matched
    }

    @available(iOS 8.0, *)
    public static func isSystemVersionMatch(_ major:Int?, _ minor:Int?, _ patch:Int?)->Bool {
        let currentVersion = ProcessInfo.processInfo.operatingSystemVersion
        let majorMatch = major == nil ? true : currentVersion.majorVersion == major
        let minorMatch = minor == nil ? true : currentVersion.minorVersion == minor
        let patchMatch = patch == nil ? true : currentVersion.patchVersion == patch
        return majorMatch && minorMatch && patchMatch
    }

}
