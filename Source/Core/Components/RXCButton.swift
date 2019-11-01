//
//  RXCButton.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/27/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

///可以设置touch扩展范围的Button
open class RXCButton: UIButton {

    /// positive means expand, negtive means shrink
    open var touchAeraExpandOffset:UIEdgeInsets?

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let inset:UIEdgeInsets = self.touchAeraExpandOffset else {
            return super.point(inside: point, with: event)
        }
        var bounds:CGRect = self.bounds
        bounds = bounds.inset(by: UIEdgeInsets(top: -inset.top, left: -inset.left, bottom: -inset.bottom, right: -inset.right))
        return bounds.contains(point)
    }

}
