//
//  RXCComponents.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public struct RXCComponents {

    public static var defaultNavigationBarContentHeight:CGFloat {
        if #available(iOS 13, *) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 50
            }else {
                return 44
            }
        }
        return 44
    }

    public static var defaultTabBarContentHeight:CGFloat {
        if #available(iOS 13, *) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 50
            }else {
                return 49
            }
        }
        return 49
    }

    @available(iOS 11, *)
    public static var mainWindowSafeAreaInset: UIEdgeInsets {
        let window:UIWindow? = UIApplication.shared.windows.first
        return window?.safeAreaInsets ?? UIEdgeInsets.zero
    }

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
