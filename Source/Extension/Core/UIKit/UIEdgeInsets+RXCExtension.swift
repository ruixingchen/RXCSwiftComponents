//
//  UIEdgeInsets+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/16/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {

    ///生成一个方形的范围
    static func square(side:CGFloat)->UIEdgeInsets {
        return UIEdgeInsets(top: side, left: side, bottom: side, right: side)
    }

}
