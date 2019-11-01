//
//  Self+Link.swift
//  CoolMarket
//
//  Created by ruixingchen on 2018/5/11.
//  Copyright © 2018 CoolApk. All rights reserved.
//

import AsyncDisplayKit

/// 为style添加链式响应
public extension ASLayoutElementStyle {

    // width

    @discardableResult
    func width(points value: CGFloat) -> Self {
        self.width = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func width(fraction value: CGFloat) -> Self {
        self.width = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func fillWidth() -> Self {
        self.width = ASDimension(unit: .fraction, value: 1.0)
        return self
    }

    @discardableResult
    func maxWidth(points value: CGFloat) -> Self {
        self.maxWidth = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func maxWidth(fraction value: CGFloat) -> Self {
        self.maxWidth = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func minWidth(points value: CGFloat) -> Self {
        self.minWidth = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func minWidth(fraction value: CGFloat) -> Self {
        self.minWidth = ASDimension(unit: .fraction, value: value)
        return self
    }

    //height

    @discardableResult
    func height(points value: CGFloat) -> Self {
        self.height = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func height(fraction value: CGFloat) -> Self {
        self.height = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func fillHeight() -> Self {
        self.height = ASDimension(unit: .fraction, value: 1.0)
        return self
    }

    @discardableResult
    func maxHeight(points value: CGFloat) -> Self {
        self.maxHeight = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func maxHeight(fraction value: CGFloat) -> Self {
        self.maxHeight = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func minHeight(points value: CGFloat) -> Self {
        self.minHeight = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func minHeight(fraction value: CGFloat) -> Self {
        self.minHeight = ASDimension(unit: .fraction, value: value)
        return self
    }

    //size

    @discardableResult
    func preferredSize(w: CGFloat, h: CGFloat) -> Self {
        self.preferredSize = CGSize(width: w, height: h)
        return self
    }

    @discardableResult
    func minSize(w: CGFloat, h: CGFloat) -> Self {
        self.minSize = CGSize(width: w, height: h)
        return self
    }

    @discardableResult
    func maxSize(w: CGFloat, h: CGFloat) -> Self {
        self.maxSize = CGSize(width: w, height: h)
        return self
    }

    //flex

    @discardableResult
    func flexible(_ value: CGFloat=1) -> Self {
        self.flexGrow(value).flexShrink(value)
        return self
    }

    @discardableResult
    func unflexible() -> Self {
        self.flexGrow(0).flexShrink(0)
        return self
    }

    @discardableResult
    func flexGrow(_ value: CGFloat=1) -> Self {
        self.flexGrow = value
        return self
    }

    @discardableResult
    func flexShrink(_ value: CGFloat=1) -> Self {
        self.flexShrink = value
        return self
    }

    //位置

    @discardableResult
    func spacingBefore(_ value: CGFloat) -> Self {
        self.spacingBefore = value
        return self
    }

    @discardableResult
    func spacingAfter(_ value: CGFloat) -> Self {
        self.spacingAfter = value
        return self
    }

}
