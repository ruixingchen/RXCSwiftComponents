//
//  ASLayoutElement+Link.swift
//  CoolMarket
//
//  Created by ruixingchen on 4/12/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import AsyncDisplayKit

/// 为style添加链式响应
public extension ASLayoutElement {

    // width

    @discardableResult
    func width(points value: CGFloat) -> Self {
        self.style.width = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func width(fraction value: CGFloat) -> Self {
        self.style.width = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func fillWidth() -> Self {
        self.style.width = ASDimension(unit: .fraction, value: 1.0)
        return self
    }

    @discardableResult
    func maxWidth(points value: CGFloat) -> Self {
        self.style.maxWidth = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func maxWidth(fraction value: CGFloat) -> Self {
        self.style.maxWidth = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func minWidth(points value: CGFloat) -> Self {
        self.style.minWidth = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func minWidth(fraction value: CGFloat) -> Self {
        self.style.minWidth = ASDimension(unit: .fraction, value: value)
        return self
    }

    //height

    @discardableResult
    func height(points value: CGFloat) -> Self {
        self.style.height = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func height(fraction value: CGFloat) -> Self {
        self.style.height = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func fillHeight() -> Self {
        self.style.height = ASDimension(unit: .fraction, value: 1.0)
        return self
    }

    @discardableResult
    func maxHeight(points value: CGFloat) -> Self {
        self.style.maxHeight = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func maxHeight(fraction value: CGFloat) -> Self {
        self.style.maxHeight = ASDimension(unit: .fraction, value: value)
        return self
    }

    @discardableResult
    func minHeight(points value: CGFloat) -> Self {
        self.style.minHeight = ASDimension(unit: .points, value: value)
        return self
    }

    @discardableResult
    func minHeight(fraction value: CGFloat) -> Self {
        self.style.minHeight = ASDimension(unit: .fraction, value: value)
        return self
    }

    //size

    @discardableResult
    func preferredSize(w: CGFloat, h: CGFloat) -> Self {
        self.style.preferredSize = CGSize(width: w, height: h)
        return self
    }

    @discardableResult
    func minSize(w: CGFloat, h: CGFloat) -> Self {
        self.style.minSize = CGSize(width: w, height: h)
        return self
    }

    @discardableResult
    func maxSize(w: CGFloat, h: CGFloat) -> Self {
        self.style.maxSize = CGSize(width: w, height: h)
        return self
    }

    //flex

    @discardableResult
    func flexible(_ value: CGFloat=1) -> Self {
        self.style.flexGrow(value).flexShrink(value)
        return self
    }

    @discardableResult
    func unflexible() -> Self {
        self.style.flexGrow(0).flexShrink(0)
        return self
    }

    @discardableResult
    func flexGrow(_ value: CGFloat=1) -> Self {
        self.style.flexGrow = value
        return self
    }

    @discardableResult
    func flexShrink(_ value: CGFloat=1) -> Self {
        self.style.flexShrink = value
        return self
    }

    //位置

    @discardableResult
    func spacingBefore(_ value: CGFloat) -> Self {
        self.style.spacingBefore = value
        return self
    }

    @discardableResult
    func spacingAfter(_ value: CGFloat) -> Self {
        self.style.spacingAfter = value
        return self
    }

}

