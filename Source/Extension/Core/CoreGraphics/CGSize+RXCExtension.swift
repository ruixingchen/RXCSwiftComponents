//
//  CGSize+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/4/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import CoreGraphics
import AVFoundation

public extension CGSize {

    ///保持当前比例, 最大的填充约束尺寸的尺寸
    func fill(in constraint:CGSize)->CGSize {
        return AVMakeRect(aspectRatio: self, insideRect: CGRect(origin: CGPoint.zero, size: constraint)).size
    }

}
