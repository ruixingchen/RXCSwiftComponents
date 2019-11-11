//
//  RXCFakeNavigationBar.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/6/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///一个假的NavigationBar, 尽量做到和系统NavigationBar一致的View层级, 默认只会显示基础的View, 左右有按钮, 中间是title, 如果想要自定义, 可以继承
open class RXCFakeNavigationBar: UIView {

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

    ///用barBackgroundView填充顶部的空间,模仿系统navBar的行为, 具体的请看layout里面的代码
    open var barBackgroundViewFillTopSpace:Bool = true {didSet {self.setNeedsLayout()}}

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSetupSubviews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func initSetupSubviews() {
        if #available(iOS 13, *) {
            self.shadowView.backgroundColor = UIColor.init(dynamicProvider: { (trait) -> UIColor in
                switch trait.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
                default: return UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                }
            })
        }else {
            //这个颜色取自 iOS 12.4
            self.shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
        self.barBackgroundView.addSubview(self.shadowView)
        self.addSubview(self.barBackgroundView)
        self.addSubview(self.barContentView)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if true {
            ///布局background
            if self.barBackgroundViewFillTopSpace {
                self.barBackgroundView.frame = CGRect(x: 0, y: -self.frame.origin.y, width: self.bounds.width, height: self.bounds.height+self.frame.origin.y)
            }else {
                self.barBackgroundView.frame = self.bounds
            }
            var displayScale:CGFloat
            if #available(iOS 13, *) {
                displayScale = UITraitCollection.current.displayScale
                if displayScale <= 0 {
                    displayScale = UIScreen.main.scale
                }
            }else {
                displayScale = UIScreen.main.scale
            }
            self.shadowView.frame = CGRect(x: 0, y: self.barBackgroundView.bounds.height, width: self.barBackgroundView.bounds.width, height: 1/displayScale)
        }
        if true {
            //布局content
            self.barContentView.frame = self.bounds
            //左右的按钮保证每个有至少24宽度的情况下确保中间的title能完整显示
            //确保title显示在正中央
            self.titleLabel.sizeToFit()

            if (self.bounds.width - self.titleLabel.frame.width)/CGFloat(max(self.leftButtons.count, self.rightButtons.count)) < 24 {
                var frame = self.titleLabel.frame
                frame.size.width = self.bounds.width - CGFloat(max(self.leftButtons.count, self.rightButtons.count))*24
                self.titleLabel.frame = frame
            }

            let buttonWidth = (self.bounds.width - self.titleLabel.frame.width)/CGFloat(max(self.leftButtons.count, self.rightButtons.count))
            for i in self.leftButtons {
                
            }

        }
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

