//
//  RXCMisc.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public struct RXCMisc {

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

}
