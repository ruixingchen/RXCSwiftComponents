//
//  RXCScrollViewProtocol.swift
//  CoolMarket
//
//  Created by ruixingchen on 9/18/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

///通过一个协议来统一ASDK和UIKit中的ScrollView
public protocol RXCScrollViewProtocol: RXCViewProtocol {

    var rsc_contentOffset: CGPoint {get set}

    var rsc_contentSize: CGSize {get set}

    var rsc_contentInset: UIEdgeInsets {get set}

    @available(iOS 11.0, *)
    var rsc_adjustedContentInset: UIEdgeInsets { get }

    @available(iOS 11.0, *)
    func rsc_adjustedContentInsetDidChange()

    @available(iOS 11.0, *)
    var rsc_contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {get set}

    @available(iOS 13.0, *)
    var rsc_automaticallyAdjustsScrollIndicatorInsets: Bool {get set}

    @available(iOS 11.0, *)
    var rsc_contentLayoutGuide: UILayoutGuide { get }

    @available(iOS 11.0, *)
    var rsc_frameLayoutGuide: UILayoutGuide { get }

    var rsc_delegate: UIScrollViewDelegate? {get set}

    var rsc_isDirectionalLockEnabled: Bool {get set}

    var rsc_bounces: Bool {get set}

    var rsc_alwaysBounceVertical: Bool {get set}

    var rsc_alwaysBounceHorizontal: Bool {get set}

    var rsc_isPagingEnabled: Bool {get set}

    var rsc_isScrollEnabled: Bool {get set}

    var rsc_showsVerticalScrollIndicator: Bool {get set}

    var rsc_showsHorizontalScrollIndicator: Bool {get set}

    var rsc_indicatorStyle: UIScrollView.IndicatorStyle {get set}


    @available(iOS 11.1, *)
    var rsc_verticalScrollIndicatorInsets: UIEdgeInsets {get set}

    @available(iOS 11.1, *)
    var rsc_horizontalScrollIndicatorInsets: UIEdgeInsets {get set}

    var rsc_scrollIndicatorInsets: UIEdgeInsets {get set}

    @available(iOS 3.0, *)
    var rsc_decelerationRate: UIScrollView.DecelerationRate {get set}

    var rsc_indexDisplayMode: UIScrollView.IndexDisplayMode {get set}

    func rsc_setContentOffset(_ contentOffset: CGPoint, animated: Bool)

    func rsc_scrollRectToVisible(_ rect: CGRect, animated: Bool)

    func rsc_flashScrollIndicators()

    var rsc_isTracking: Bool { get }

    var rsc_isDragging: Bool { get }

    var rsc_isDecelerating: Bool { get }

    var rsc_delaysContentTouches: Bool {get set}

    var rsc_canCancelContentTouches: Bool {get set}

    func rsc_touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool

    func rsc_touchesShouldCancel(in view: UIView) -> Bool

    var rsc_minimumZoomScale: CGFloat {get set}

    var rsc_maximumZoomScale: CGFloat {get set}

    @available(iOS 3.0, *)
    var rsc_zoomScale: CGFloat {get set}

    @available(iOS 3.0, *)
    func rsc_setZoomScale(_ scale: CGFloat, animated: Bool)

    @available(iOS 3.0, *)
    func rsc_zoom(to rect: CGRect, animated: Bool)

    var rsc_bouncesZoom: Bool {get set}

    var rsc_isZooming: Bool { get }

    var rsc_isZoomBouncing: Bool { get }

    var rsc_scrollsToTop: Bool {get set}

    @available(iOS 5.0, *)
    var rsc_panGestureRecognizer: UIPanGestureRecognizer { get }

    @available(iOS 5.0, *)
    var rsc_pinchGestureRecognizer: UIPinchGestureRecognizer? { get }

    var rsc_directionalPressGestureRecognizer: UIGestureRecognizer { get }

    @available(iOS 7.0, *)
    var rsc_keyboardDismissMode: UIScrollView.KeyboardDismissMode {get set}

    @available(iOS 10.0, *)
    var rsc_refreshControl: UIRefreshControl? {get set}

}
