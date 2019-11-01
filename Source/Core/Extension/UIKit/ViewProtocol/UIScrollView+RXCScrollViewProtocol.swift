//
//  UIScrollView+RXCScrollViewProtocol.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIScrollView: RXCScrollViewProtocol {

    public var rsc_contentOffset: CGPoint {
        get {return self.contentOffset}
        set {self.contentOffset = newValue}
    }

    public var rsc_contentSize: CGSize {
        get {
            return self.contentSize
        }
        set {
            self.contentSize = newValue
        }
    }

    public var rsc_contentInset: UIEdgeInsets {
        get {return self.contentInset}
        set {self.contentInset = newValue}
    }

    @available(iOS 11.0, *)
    public var rsc_adjustedContentInset: UIEdgeInsets {
        return self.adjustedContentInset
    }

    @available(iOS 11.0, *)
    public func rsc_adjustedContentInsetDidChange() {
        return self.adjustedContentInsetDidChange()
    }

    @available(iOS 11.0, *)
    public var rsc_contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {
        get {
            return self.contentInsetAdjustmentBehavior
        }
        set {
            self.contentInsetAdjustmentBehavior = newValue
        }
    }

    @available(iOS 13.0, *)
    public var rsc_automaticallyAdjustsScrollIndicatorInsets: Bool {
        get {
            return self.automaticallyAdjustsScrollIndicatorInsets
        }
        set {
            self.automaticallyAdjustsScrollIndicatorInsets = newValue
        }
    }

    @available(iOS 11.0, *)
    public var rsc_contentLayoutGuide: UILayoutGuide {
        return self.contentLayoutGuide
    }

    @available(iOS 11.0, *)
    public var rsc_frameLayoutGuide: UILayoutGuide {
        return self.frameLayoutGuide
    }

    public var rsc_delegate: UIScrollViewDelegate? {
        get {
            return self.delegate
        }
        set {
            self.delegate = newValue
        }
    }

    public var rsc_isDirectionalLockEnabled: Bool {
        get {
            return self.isDirectionalLockEnabled
        }
        set {
            self.isDirectionalLockEnabled = newValue
        }
    }

    public var rsc_bounces: Bool {
        get {
            return self.bounces
        }
        set {
            self.bounces = newValue
        }
    }

    public var rsc_alwaysBounceVertical: Bool {
        get {
            return self.alwaysBounceVertical
        }
        set {
            self.alwaysBounceVertical = newValue
        }
    }

    public var rsc_alwaysBounceHorizontal: Bool {
        get {
            return self.alwaysBounceHorizontal
        }
        set {
            self.alwaysBounceHorizontal = newValue
        }
    }

    public var rsc_isPagingEnabled: Bool {
        get {
            return self.isPagingEnabled
        }
        set {
            self.isPagingEnabled = newValue
        }
    }

    public var rsc_isScrollEnabled: Bool {
        get {
            return self.isScrollEnabled
        }
        set {
            self.isScrollEnabled = newValue
        }
    }

    public var rsc_showsVerticalScrollIndicator: Bool {
        get {
            return self.showsVerticalScrollIndicator
        }
        set {
            self.showsVerticalScrollIndicator = newValue
        }
    }

    public var rsc_showsHorizontalScrollIndicator: Bool {
        get {
            return self.showsHorizontalScrollIndicator
        }
        set {
            self.showsHorizontalScrollIndicator = newValue
        }
    }

    public var rsc_indicatorStyle: UIScrollView.IndicatorStyle {
        get {
            return self.indicatorStyle
        }
        set {
            self.indicatorStyle = newValue
        }
    }

    @available(iOS 11.1, *)
    public var rsc_verticalScrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.verticalScrollIndicatorInsets
        }
        set {
            self.verticalScrollIndicatorInsets = newValue
        }
    }

    @available(iOS 11.1, *)
    public var rsc_horizontalScrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.horizontalScrollIndicatorInsets
        }
        set {
            self.horizontalScrollIndicatorInsets = newValue
        }
    }

    public var rsc_scrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.scrollIndicatorInsets
        }
        set {
            self.scrollIndicatorInsets = newValue
        }
    }

    public var rsc_decelerationRate: UIScrollView.DecelerationRate {
        get {
            return self.decelerationRate
        }
        set {
            self.decelerationRate = newValue
        }
    }

    public var rsc_indexDisplayMode: UIScrollView.IndexDisplayMode {
        get {
            return self.indexDisplayMode
        }
        set {
            self.indexDisplayMode = newValue
        }
    }

    public func rsc_setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        self.setContentOffset(contentOffset, animated: animated)
    }

    public func rsc_scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        self.scrollRectToVisible(rect, animated: animated)
    }

    public func rsc_flashScrollIndicators() {
        self.flashScrollIndicators()
    }

    public var rsc_isTracking: Bool {
        return self.isTracking
    }

    public var rsc_isDragging: Bool {
        return self.isDragging
    }

    public var rsc_isDecelerating: Bool {
        return self.isDecelerating
    }

    public var rsc_delaysContentTouches: Bool {
        get {
            return self.delaysContentTouches
        }
        set {
            self.delaysContentTouches = newValue
        }
    }

    public var rsc_canCancelContentTouches: Bool {
        get {
            return self.canCancelContentTouches
        }
        set {
            self.canCancelContentTouches = newValue
        }
    }

    public func rsc_touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        self.touchesShouldBegin(touches, with: event, in: view)
    }

    public func rsc_touchesShouldCancel(in view: UIView) -> Bool {
        return self.touchesShouldCancel(in: view)
    }

    public var rsc_minimumZoomScale: CGFloat {
        get {
            return self.minimumZoomScale
        }
        set {
            self.minimumZoomScale = newValue
        }
    }

    public var rsc_maximumZoomScale: CGFloat {
        get {
            return self.maximumZoomScale
        }
        set {
            self.maximumZoomScale = newValue
        }
    }

    public var rsc_zoomScale: CGFloat {
        get {
            return self.zoomScale
        }
        set {
            self.zoomScale = newValue
        }
    }

    public func rsc_setZoomScale(_ scale: CGFloat, animated: Bool) {
        self.setZoomScale(scale, animated: animated)
    }

    public func rsc_zoom(to rect: CGRect, animated: Bool) {
        self.zoom(to: rect, animated: animated)
    }

    public var rsc_bouncesZoom: Bool {
        get {
            return self.bouncesZoom
        }
        set {
            self.bouncesZoom = newValue
        }
    }

    public var rsc_isZooming: Bool {
        return self.isZooming
    }

    public var rsc_isZoomBouncing: Bool {
        return self.isZoomBouncing
    }

    public var rsc_scrollsToTop: Bool {
        get {
            return self.scrollsToTop
        }
        set {
            self.scrollsToTop = newValue
        }
    }

    public var rsc_panGestureRecognizer: UIPanGestureRecognizer {
        return self.panGestureRecognizer
    }

    public var rsc_pinchGestureRecognizer: UIPinchGestureRecognizer? {
        return self.pinchGestureRecognizer
    }

    public var rsc_directionalPressGestureRecognizer: UIGestureRecognizer {
        return self.directionalPressGestureRecognizer
    }

    public var rsc_keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        get {
            return self.keyboardDismissMode
        }
        set {
            self.keyboardDismissMode = newValue
        }
    }

    public var rsc_refreshControl: UIRefreshControl? {
        get {
            return self.refreshControl
        }
        set {
            self.refreshControl = newValue
        }
    }

}
