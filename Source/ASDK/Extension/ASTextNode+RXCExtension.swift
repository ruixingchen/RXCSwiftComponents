//
//  ASTextNode+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 2/28/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public extension ASTextNode {

    @discardableResult
    func UILabelStyle() -> Self {
        self.truncationMode = .byTruncatingTail
        //label.passthroughNonlinkTouches = false
        self.maximumNumberOfLines = 1
        return self
    }

    @discardableResult
    func touchable()->Self {
        self.UILabelStyle()
        self.passthroughNonlinkTouches = true
        self.isUserInteractionEnabled = true
        return self
    }

    @discardableResult
    func untouchable()->Self {
        self.UILabelStyle()
        self.isUserInteractionEnabled = false
        self.passthroughNonlinkTouches = false
        if self.supportsLayerBacking {
            self.isLayerBacked = true
        }
        return self
    }

}
