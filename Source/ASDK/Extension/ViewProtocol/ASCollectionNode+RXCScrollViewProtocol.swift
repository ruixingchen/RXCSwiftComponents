//
//  ASCollectionNode+RXCScrollViewProtocol.swift
//  RXCEntityListViewController
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
#if canImport(AsyncDisplayKit)
import AsyncDisplayKit
#endif

#if (CanUseASDK || canImport(AsyncDisplayKit))
extension ASCollectionNode: RXCScrollViewProtocol {

    public var rsc_contentOffset: CGPoint {
        get {return self.contentOffset}
        set {self.contentOffset = newValue}
    }

    public var rsc_contentSize: CGSize {
        get {
            return self.view.contentSize
        }
        set {
            self.view.contentSize = newValue
        }
    }

    public var rsc_contentInset: UIEdgeInsets {
        get {return self.contentInset}
        set {self.contentInset = newValue}
    }

    @available(iOS 11.0, *)
    public var rsc_adjustedContentInset: UIEdgeInsets {
        return self.view.adjustedContentInset
    }

    @available(iOS 11.0, *)
    public func rsc_adjustedContentInsetDidChange() {
        return self.view.adjustedContentInsetDidChange()
    }

    @available(iOS 11.0, *)
    public var rsc_contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {
        get {
            return self.view.contentInsetAdjustmentBehavior
        }
        set {
            self.view.contentInsetAdjustmentBehavior = newValue
        }
    }

    @available(iOS 13.0, *)
    public var rsc_automaticallyAdjustsScrollIndicatorInsets: Bool {
        get {
            return self.view.automaticallyAdjustsScrollIndicatorInsets
        }
        set {
            self.view.automaticallyAdjustsScrollIndicatorInsets = newValue
        }
    }

    @available(iOS 11.0, *)
    public var rsc_contentLayoutGuide: UILayoutGuide {
        return self.view.contentLayoutGuide
    }

    @available(iOS 11.0, *)
    public var rsc_frameLayoutGuide: UILayoutGuide {
        return self.view.frameLayoutGuide
    }

    public var rsc_delegate: UIScrollViewDelegate? {
        get {
            return self.delegate
        }
        set {
            if let valid = newValue {
                precondition(valid is ASCollectionDelegate, "ASCollectionNode要求delegate必须同时遵循ASCollectionDelegate")
                self.delegate = (valid as! ASCollectionDelegate)
            }else {
                self.delegate = nil
            }
        }
    }

    public var rsc_isDirectionalLockEnabled: Bool {
        get {
            return self.view.isDirectionalLockEnabled
        }
        set {
            self.view.isDirectionalLockEnabled = newValue
        }
    }

    public var rsc_bounces: Bool {
        get {
            return self.view.bounces
        }
        set {
            self.view.bounces = newValue
        }
    }

    public var rsc_alwaysBounceVertical: Bool {
        get {
            return self.view.alwaysBounceVertical
        }
        set {
            self.view.alwaysBounceVertical = newValue
        }
    }

    public var rsc_alwaysBounceHorizontal: Bool {
        get {
            return self.view.alwaysBounceHorizontal
        }
        set {
            self.view.alwaysBounceHorizontal = newValue
        }
    }

    public var rsc_isPagingEnabled: Bool {
        get {
            return self.view.isPagingEnabled
        }
        set {
            self.view.isPagingEnabled = newValue
        }
    }

    public var rsc_isScrollEnabled: Bool {
        get {
            return self.view.isScrollEnabled
        }
        set {
            self.view.isScrollEnabled = newValue
        }
    }

    public var rsc_showsVerticalScrollIndicator: Bool {
        get {
            return self.view.showsVerticalScrollIndicator
        }
        set {
            self.view.showsVerticalScrollIndicator = newValue
        }
    }

    public var rsc_showsHorizontalScrollIndicator: Bool {
        get {
            return self.view.showsHorizontalScrollIndicator
        }
        set {
            self.view.showsHorizontalScrollIndicator = newValue
        }
    }

    public var rsc_indicatorStyle: UIScrollView.IndicatorStyle {
        get {
            return self.view.indicatorStyle
        }
        set {
            self.view.indicatorStyle = newValue
        }
    }

    @available(iOS 11.1, *)
    public var rsc_verticalScrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.view.verticalScrollIndicatorInsets
        }
        set {
            self.view.verticalScrollIndicatorInsets = newValue
        }
    }

    @available(iOS 11.1, *)
    public var rsc_horizontalScrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.view.horizontalScrollIndicatorInsets
        }
        set {
            self.view.horizontalScrollIndicatorInsets = newValue
        }
    }

    public var rsc_scrollIndicatorInsets: UIEdgeInsets {
        get {
            return self.view.scrollIndicatorInsets
        }
        set {
            self.view.scrollIndicatorInsets = newValue
        }
    }

    public var rsc_decelerationRate: UIScrollView.DecelerationRate {
        get {
            return self.view.decelerationRate
        }
        set {
            self.view.decelerationRate = newValue
        }
    }

    public var rsc_indexDisplayMode: UIScrollView.IndexDisplayMode {
        get {
            return self.view.indexDisplayMode
        }
        set {
            self.view.indexDisplayMode = newValue
        }
    }

    public func rsc_setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        self.setContentOffset(contentOffset, animated: animated)
    }

    public func rsc_scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        self.view.scrollRectToVisible(rect, animated: animated)
    }

    public func rsc_flashScrollIndicators() {
        self.view.flashScrollIndicators()
    }

    public var rsc_isTracking: Bool {
        return self.view.isTracking
    }

    public var rsc_isDragging: Bool {
        return self.view.isDragging
    }

    public var rsc_isDecelerating: Bool {
        return self.view.isDecelerating
    }

    public var rsc_delaysContentTouches: Bool {
        get {
            return self.view.delaysContentTouches
        }
        set {
            self.view.delaysContentTouches = newValue
        }
    }

    public var rsc_canCancelContentTouches: Bool {
        get {
            return self.view.canCancelContentTouches
        }
        set {
            self.view.canCancelContentTouches = newValue
        }
    }

    public func rsc_touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        self.view.touchesShouldBegin(touches, with: event, in: view)
    }

    public func rsc_touchesShouldCancel(in view: UIView) -> Bool {
        return self.view.touchesShouldCancel(in: view)
    }

    public var rsc_minimumZoomScale: CGFloat {
        get {
            return self.view.minimumZoomScale
        }
        set {
            self.view.minimumZoomScale = newValue
        }
    }

    public var rsc_maximumZoomScale: CGFloat {
        get {
            return self.view.maximumZoomScale
        }
        set {
            self.view.maximumZoomScale = newValue
        }
    }

    public var rsc_zoomScale: CGFloat {
        get {
            return self.view.zoomScale
        }
        set {
            self.view.zoomScale = newValue
        }
    }

    public func rsc_setZoomScale(_ scale: CGFloat, animated: Bool) {
        self.view.setZoomScale(scale, animated: animated)
    }

    public func rsc_zoom(to rect: CGRect, animated: Bool) {
        self.view.zoom(to: rect, animated: animated)
    }

    public var rsc_bouncesZoom: Bool {
        get {
            return self.view.bouncesZoom
        }
        set {
            self.view.bouncesZoom = newValue
        }
    }

    public var rsc_isZooming: Bool {
        return self.view.isZooming
    }

    public var rsc_isZoomBouncing: Bool {
        return self.view.isZoomBouncing
    }

    public var rsc_scrollsToTop: Bool {
        get {
            return self.view.scrollsToTop
        }
        set {
            self.view.scrollsToTop = newValue
        }
    }

    public var rsc_panGestureRecognizer: UIPanGestureRecognizer {
        return self.view.panGestureRecognizer
    }

    public var rsc_pinchGestureRecognizer: UIPinchGestureRecognizer? {
        return self.view.pinchGestureRecognizer
    }

    public var rsc_directionalPressGestureRecognizer: UIGestureRecognizer {
        return self.view.directionalPressGestureRecognizer
    }

    public var rsc_keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        get {
            return self.view.keyboardDismissMode
        }
        set {
            self.view.keyboardDismissMode = newValue
        }
    }

    public var rsc_refreshControl: UIRefreshControl? {
        get {
            return self.view.refreshControl
        }
        set {
            self.view.refreshControl = newValue
        }
    }

}
#endif
