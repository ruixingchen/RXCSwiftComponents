//
//  RXCFakeNavigationBar.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/6/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///一个假的NavigationBar, 尽量做到和系统NavigationBar一致的View层级, 默认只会显示基础的View, 左右有按钮, 中间是title, 如果想要自定义, 可以继承
@available(*, deprecated, message: "未完成, 不要使用")
private class RXCFakeNavigationBar: UIView {

    public private(set) var leftButtons:[UIButton] = []
    public private(set) var rightButtons:[UIButton] = []

    open var barBackgroundView:UIView = UIView()
    open var barContentView:UIView = UIView()
    open var shadowView:UIView = UIView()

    open lazy var effectView:UIVisualEffectView? = UIVisualEffectView(effect: self.visualEffect)

    internal var _titleLabel:UILabel?
    open var titleLabel:UILabel {
        if self._titleLabel == nil {
            self._titleLabel = UILabel()
        }
        return _titleLabel!
    }

    internal var _visualEffect:UIVisualEffect?
    open var visualEffect:UIVisualEffect {
        get {
            var effect:UIVisualEffect! = self._visualEffect
            if effect == nil {
                if #available(iOS 13, *) {
                    effect = UIBlurEffect(style: .systemChromeMaterial)
                }else if #available(iOS 10, *) {
                    effect = UIBlurEffect(style: .regular)
                }else {
                    effect = UIBlurEffect(style: .light)
                }
            }
            return effect
        }
        set {
            self._visualEffect = newValue
            if self.effectView != nil {
                UIView.animate(withDuration: 0.25) {
                    self.effectView?.effect = newValue
                }
            }
        }
    }

    open var isTranslucent:Bool = true {
        didSet {
            self.didChangeTranslucent()
        }
    }

    internal var _barTintColor:UIColor?
    open var barTintColor:UIColor? {
        get {
            return self._barTintColor
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSetupSubviews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func initSetupSubviews() {
        self.addSubview(self.barBackgroundView)
        self.addSubview(self.barContentView)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        self.barBackgroundView.frame = CGRect(x: 0, y: -self.frame.origin.y, width: self.bounds.width, height: self.bounds.height+self.frame.origin.y)
        self.barContentView.frame = self.bounds

    }

    open func didChangeTranslucent() {
        if self.isTranslucent {
            if self.effectView == nil {
                var effect:UIVisualEffect! = self.visualEffect
                if effect == nil {
                    if #available(iOS 13, *) {
                        effect = UIBlurEffect(style: .systemChromeMaterial)
                    }else if #available(iOS 10, *) {
                        effect = UIBlurEffect(style: .regular)
                    }else {
                        effect = UIBlurEffect(style: .light)
                    }
                }
                self.effectView = UIVisualEffectView(effect: effect!)
            }
        }else {

        }
    }


}
