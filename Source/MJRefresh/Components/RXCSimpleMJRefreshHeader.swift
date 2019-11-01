//
//  RXCSimpleMJRefreshHeader.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/13/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit
#if canImport(MJRefresh)
import MJRefresh
#endif

#if canImport(MJRefresh)
///一个简单的头部刷新组件, 只有一个平淡且枯燥的菊花在转
open class RXCSimpleMJRefreshHeader: MJRefreshHeader {

    open var indicator:UIActivityIndicatorView

    public init(style:UIActivityIndicatorView.Style, target:AnyObject?, action:Selector?) {
        self.indicator = UIActivityIndicatorView(style: style)
        super.init(frame: CGRect.zero)
        self.setRefreshingTarget(target, refreshingAction: action)
        self.addSubview(indicator)
    }

    public init(style:UIActivityIndicatorView.Style, refreshingBlock: MJRefreshComponentRefreshingBlock?) {
        self.indicator = UIActivityIndicatorView(style: style)
        super.init(frame: CGRect.zero)
        self.refreshingBlock = refreshingBlock
        self.addSubview(indicator)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepare() {
        super.prepare()
        self.indicator.startAnimating()
    }

    public override func placeSubviews() {
        super.placeSubviews()
        self.indicator.center = self.center
    }

    public override var pullingPercent: CGFloat {
        didSet {
            ///这里不按照完整的比例进行, 当指示器能看见的时候才更新alpha
            let space:CGFloat = 0.6
            var alpha:CGFloat = (pullingPercent-space)/(1-space)
            if alpha < 0 {
                alpha = 0
            }else if alpha > 1.0 {
                alpha = 1.0
            }
            self.indicator.alpha = alpha
        }
    }

    public override var state: MJRefreshState {
        didSet {
//            if state == .idle || state == .noMoreData {
//                self.indicator.stopAnimating()
//            }else{
//                self.indicator.startAnimating()
//            }
        }
    }

}
#endif
