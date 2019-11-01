//
//  UIView+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 03/04/2018.
//  Copyright © 2018 CoolApk. All rights reserved.
//

import UIKit
#if canImport(MBProgressHUD)
import MBProgressHUD
#endif

public extension UIView {

    #if DEBUG||debug
    func paintSubviewsWithColor() {
        self.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.6)
        for i in subviews {
            i.paintSubviewsWithColor()
        }
    }
    #endif

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    @available(iOS 11.0, *)
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    #if canImport(MBProgressHUD)
    func findAllMBHUD()->[MBProgressHUD] {
        var huds:[MBProgressHUD] = []
        for i in self.subviews {
            if let hud = i as? MBProgressHUD {
                huds.append(hud)
            }
        }
        return huds
    }
    #endif

    ///当前显示的内容转换成UIImage
    func toImage()->UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }

    ///找到这个View及其下面的子View中是第一响应者的View(不包括自己)
    func findFirstResponderView()->UIView? {
        return self.findInSubviews(match: {$0.isFirstResponder})
    }

    /// 在所有子View中查找符合条件的View(不包括自己)
    ///
    /// - Parameters:
    ///   - deepLimit: 搜索的层次深度限制, 自己是第0层, 自己的subviews为1层, 默认不限制
    ///   - match: 匹配条件
    func findInSubviews(depthLimit:Int=0, match:(UIView)->Bool) -> UIView? {
        for i in self.subviews {
            if let matched = i._findInSubviews(depthLimit: depthLimit, depth: 1, match: match) {
                return matched
            }
        }
        return nil
    }

    private func _findInSubviews(depthLimit:Int, depth:Int, match:(UIView)->Bool)->UIView? {
        if match(self) {return self}
        let nextDepth = depth + 1
        if depthLimit > 0 && nextDepth > depthLimit {return nil}
        for i in self.subviews {
            if let matched = i._findInSubviews(depthLimit: depthLimit, depth: nextDepth, match: match) {
                return matched
            }
        }
        return nil
    }

    /// 在superview链中寻找匹配的目标
    ///
    /// - Parameters:
    ///   - deepLimit: 深度限制,自己为0层,自己的subviews为1层
    func findInSuperviews(depthLimit:Int=0, match:(UIView)->Bool)->UIView? {
        var _super:UIView? = self.superview
        var depth:Int = 1
        while _super != nil && !match(_super!) {
            depth += 1
            if depthLimit > 0 && depth > depthLimit {
                break
            }
            _super = _super?.superview
        }
        return _super
    }

}
