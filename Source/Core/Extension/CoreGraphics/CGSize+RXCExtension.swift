//
//  CGSize+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/4/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import CoreGraphics

public extension CGSize {

    ///保持当前比例, 最大的填充约束尺寸的尺寸
    func fill(in constraint:CGSize)->CGSize {
        let ratio = self.width/self.height
        let constraintRatio = constraint.width/constraint.height
        if ratio > constraintRatio {
            //当前size比约束size更扁, 以当前size的宽度作为标准
            let newWidth = constraint.width
            let newHeight = newWidth/ratio
            return CGSize(width: newWidth, height: newHeight)
        }else {
            //当前size比约束size更瘦, 以当前size的高度作为标准
            let newHeight = constraint.height
            let newWidth = newHeight*ratio
            return CGSize(width: newWidth, height: newHeight)
        }
    }

}
