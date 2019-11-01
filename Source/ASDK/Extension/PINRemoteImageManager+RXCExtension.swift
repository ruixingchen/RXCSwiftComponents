//
//  PINRemoteImageManager+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/6/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation
#if canImport(AsyncDisplayKit) && canImport(PINRemoteImage)
import AsyncDisplayKit
import PINRemoteImage
#endif

#if canImport(AsyncDisplayKit) && canImport(PINRemoteImage)
public extension PINRemoteImageManager {

    static var shared_asdk:PINRemoteImageManager {
        return ASPINRemoteImageDownloader.shared().sharedPINRemoteImageManager()
    }

}

#endif
