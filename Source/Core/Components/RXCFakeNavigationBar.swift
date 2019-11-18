//
//  RXCFakeNavigationBar.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/6/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///一个假的NavigationBar, 尽量做到和系统NavigationBar一致的View层级, 默认只会显示基础的View, 左右有按钮, 中间是title, 如果想要自定义, 可以继承
///a fake NavigationBar, try hard to keep the same api with system UINavigationBar, override to customize
open class RXCFakeNavigationBar: UIView {

    static func onMain(closure:@escaping ()->Void) {
        if Thread.isMainThread {
            closure()
        }else {
            DispatchQueue.main.async(execute: closure)
        }
    }

    ///用barBackgroundView填充顶部的空间,模仿系统navBar的行为, 具体的请看layout里面的代码
    open var barBackgroundViewFillTopSpace:Bool = true {didSet {self.setNeedsLayout()}}

    //MARK: - Views

    public private(set) var leftButtons:[UIControl] = []
    public private(set) var rightButtons:[UIControl] = []
    public private(set) var leftButtonStackView:UIStackView = UIStackView()
    public private(set) var rightButtonStackView:UIStackView = UIStackView()
    ///背景View
    open var barBackgroundView:UIView = UIView()
    ///内容View
    open var barContentView:UIView = UIView()
    ///底部的分割线
    open var shadowView:UIView = UIView()
    ///显示透明模糊效果的View
    open var effectView:TranslucentVisualEffectView?
    ///非透明模式下显示barTintColor的View, 非透明模式下还可以显示图片,但是这里不给出接口(毕竟系统也没有这个接口)
    open var colorAndImageView:UIImageView?
    ///显示标题的label
    open var titleLabel:UILabel = UILabel()

    //MARK: - Bar Property

    ///左右两边的边距
    open var spacing:CGFloat = 16 {
        didSet {
            Self.onMain() {
                if self.superview != nil {
                    self.setNeedsLayout()
                }
            }
        }
    }

    ///按钮的距离
    open var buttonSpacing:CGFloat = 8 {
        didSet {
            Self.onMain() {
                if self.superview != nil {
                    self.setNeedsLayout()
                }
            }
        }
    }

    ///透明模式下的模糊效果, 如果设置有值, 强制采用这个值, 否则采用和系统相似的值
    open var visualEffect: UIVisualEffect? {
        didSet {
            Self.onMain() {
                self.didChangeVisualEffect()
            }
        }
    }

    ///返回真实的visualEffect, effect在显示和不显示barTint的情况下是不同的
    open func realVisualEffect()->UIVisualEffect {
        if let setted = self.visualEffect {
            ///强制设置了effect
            return setted
        }
        if #available(iOS 13, *) {
            if self.barTintColor == nil {
                return UIBlurEffect(style: .systemChromeMaterial)
            }else {
                return UIBlurEffect(style: .systemUltraThinMaterial)
            }
        }else if #available(iOS 10, *) {
            if self.barTintColor == nil {
                return UIBlurEffect(style: .prominent)
            }else {
                return UIBlurEffect(style: .regular)
            }
        }else {
            //这里的值是不确定的, 外观可能不一样
            return UIBlurEffect(style: .light)
        }
    }

    open var isTranslucent:Bool = true {
        didSet {
            Self.onMain() {
                self.didChangeTranslucent()
            }
        }
    }

    ///如果设置为nil, 则会采用默认的颜色
    open var barTintColor: UIColor? {
        didSet {
            Self.onMain() {
                self.didChangeBarTintColor()
            }
        }
    }

    open func barTintColorForNonTranslucent()->UIColor {
        let defualtColor:()->UIColor = {
            if #available(iOS 13, *) {
                return UIColor.systemBackground
            }else {
                return UIColor.white
            }
        }
        return self.barTintColor ?? defualtColor()
    }

    ///标题的富文本属性
    open var titleAttributes:[NSAttributedString.Key:Any]? {
        didSet {
            Self.onMain() {
                self.didChangeTitleAttributes()
            }
        }
    }

    open func realTitleAttributes()->[NSAttributedString.Key:Any] {
        let defaultAttributes:()->[NSAttributedString.Key:Any] = {
            var dict:[NSAttributedString.Key:Any] = [:]
            if #available(iOS 13, *) {
                dict[.foregroundColor] = UIColor.label
            }else {
                dict[.foregroundColor] = UIColor.black
            }
            dict[.font] = UIFont.systemFont(ofSize: 17, weight: .bold)
            return dict
        }
        return self.titleAttributes ?? defaultAttributes()
    }

    ///向最近的VC添加观察者, 在title发生变化的时候自动更新bar的title
    open var observeViewControllerTitle:Bool = true {
        didSet {
            Self.onMain() {
                self.updateViewControllerTitleObserver()
            }
        }
    }

    //MARK: - private property

    open weak var viewController_weak:UIViewController?
    open var viewControllerObserverContext:String = UUID().uuidString

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSetupSubviews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSetupSubviews()
    }

    open func initSetupSubviews() {
        if #available(iOS 13, *) {
            self.tintColor = UIColor.systemBlue
        }else {
            self.tintColor = UIColor.blue
        }
        self.backgroundColor = UIColor.clear
        self.barBackgroundView.backgroundColor = UIColor.clear

        self.titleLabel.textAlignment = .center

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

        self.didChangeTranslucent()
        self.didChangeBarTintColor()
        self.didChangeVisualEffect()

        self.leftButtonStackView.axis = .horizontal
        self.leftButtonStackView.alignment = .center
        self.leftButtonStackView.distribution = .equalSpacing
        self.leftButtonStackView.spacing = self.buttonSpacing
        self.barContentView.addSubview(self.leftButtonStackView)
        self.rightButtonStackView.axis = .horizontal
        self.rightButtonStackView.alignment = .center
        self.rightButtonStackView.distribution = .equalSpacing
        self.rightButtonStackView.spacing = self.buttonSpacing
        self.barContentView.addSubview(self.rightButtonStackView)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutBarBackground()
        self.layoutBarContent()
    }

    ///对背景View进行布局
    open func layoutBarBackground() {
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
        //高度确保只有1像素
        self.shadowView.frame = CGRect(x: 0, y: self.barBackgroundView.bounds.height, width: self.barBackgroundView.bounds.width, height: 1/displayScale)
        self.colorAndImageView?.frame = self.barBackgroundView.bounds
        self.effectView?.frame = self.barBackgroundView.bounds
    }

    ///布局内容View
    open func layoutBarContent() {
        //布局content
        self.barContentView.frame = self.bounds
        ///优先确保左右按钮的显示
        self.leftButtons.forEach({$0.sizeToFit()})
        let leftStackWidth = self.leftButtons.reduce(0, {$0 + $1.frame.width}) + CGFloat(self.leftButtons.count-1)*self.buttonSpacing
        self.leftButtonStackView.frame = CGRect(x: self.spacing, y: 0, width: leftStackWidth, height: self.bounds.height)
        self.rightButtons.forEach({$0.sizeToFit()})
        let rightStackWidth = self.rightButtons.reduce(0, {$0 + $1.frame.width}) + CGFloat(self.rightButtons.count-1)*self.buttonSpacing
        self.rightButtonStackView.frame = CGRect(x: self.bounds.width-self.spacing-rightStackWidth, y: 0, width: rightStackWidth, height: self.bounds.height)
        //titleLabel在按钮过多的情况下是可以牺牲的
        if true {
            self.titleLabel.sizeToFit()
            ///titleLabel确保居中
            var titleMaxWidth:CGFloat
            let centerX = self.bounds.width/2
            let leftStackRight = self.leftButtonStackView.frame.origin.x + self.leftButtonStackView.frame.width
            let rightStackLeft = self.rightButtonStackView.frame.origin.x
            if leftStackRight > centerX || rightStackLeft < centerX {
                //左右的按钮发生了干涉, title宽度只能为0
                titleMaxWidth = 0
            }else {
                titleMaxWidth = min(centerX - leftStackRight, rightStackLeft - centerX)*2 - self.buttonSpacing*2
            }
            if titleMaxWidth < 0 {titleMaxWidth = 0}
            let titleWidth = min(self.titleLabel.frame.width, titleMaxWidth)
            self.titleLabel.frame = CGRect(x: centerX-titleWidth/2, y: 0, width: titleWidth, height: self.bounds.height)
        }
    }

    ///当透明模式发生变化的时候更新View
    open func didChangeTranslucent() {
        if self.isTranslucent {
            self.colorAndImageView?.removeFromSuperview()
            if self.effectView == nil {
                let effect:UIVisualEffect = self.realVisualEffect()
                self.effectView = TranslucentVisualEffectView(effect: effect)
            }
            if self.effectView?.superview == nil {
                self.barBackgroundView.addSubview(self.effectView!)
                if self.superview != nil {
                    self.setNeedsLayout()
                }
            }
            self.effectView?.setBarTintColor(self.barTintColor)
            self.effectView?.effect = self.realVisualEffect()
        }else {
            self.effectView?.removeFromSuperview()
            if self.colorAndImageView == nil {
                self.colorAndImageView = UIImageView()
            }
            if self.colorAndImageView?.superview == nil {
                self.barBackgroundView.addSubview(self.colorAndImageView!)
                if self.superview != nil {
                    self.setNeedsLayout()
                }
            }
            self.colorAndImageView?.backgroundColor = self.barTintColorForNonTranslucent()
        }
    }

    ///当模糊效果发生变化的时候更新View
    open func didChangeVisualEffect() {
        if self.isTranslucent {
            UIView.animate(withDuration: 0.25) {
                self.effectView?.effect = self.realVisualEffect()
            }
        }else {
            self.effectView?.effect = self.realVisualEffect()
        }
    }

    open func didChangeBarTintColor() {
        if self.isTranslucent {
            self.effectView?.setBarTintColor(self.barTintColor)
            self.effectView?.effect = self.realVisualEffect()
        }else {
            //非透明模式下, 颜色为nil的时候显示一个默认的颜色
            self.colorAndImageView?.backgroundColor = self.barTintColorForNonTranslucent()
        }
    }

    open func didChangeTitleAttributes() {
        let attributes = self.realTitleAttributes()
        let text = NSMutableAttributedString.init(attributedString: self.titleLabel.attributedText ?? NSAttributedString())
        text.addAttributes(attributes, range: NSRange(location: 0, length: text.length))
        self.titleLabel.attributedText = text
    }

    open override func tintColorDidChange() {
        super.tintColorDidChange()
        //当tintColor改变的时候, 需要更改所有的按钮的颜色
        self.leftButtons.forEach({$0.tintColor = self.tintColor})
        self.rightButtons.forEach({$0.tintColor = self.tintColor})
    }

    ///设置标题, 暂时只支持纯文本
    open func setTitle(_ text:String?) {
        self.titleLabel.text = text
        self.didChangeTitleAttributes()
        if self.titleLabel.superview == nil {
            self.barContentView.addSubview(self.titleLabel)
        }
        if self.superview != nil {
            self.setNeedsLayout()
        }
    }

    ///设置左边显示的按钮
    open func setLeftButtons(_ buttons:[UIButton]) {
        self.leftButtons.forEach({self.leftButtonStackView.removeArrangedSubview($0)})
        self.leftButtons = buttons
        self.leftButtons.forEach({self.leftButtonStackView.addArrangedSubview($0)})
        self.leftButtons.forEach({$0.tintColor = self.tintColor})
        if self.superview != nil {
            self.setNeedsLayout()
        }
    }

    ///设置右边显示的按钮
    open func setRightButtons(_ buttons:[UIButton]) {
        self.rightButtons.forEach({self.rightButtonStackView.removeArrangedSubview($0)})
        self.rightButtons = buttons
        self.rightButtons.forEach({self.rightButtonStackView.addArrangedSubview($0)})
        self.leftButtons.forEach({$0.tintColor = self.tintColor})
        if self.superview != nil {
            self.setNeedsLayout()
        }
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.updateViewControllerTitleObserver()
    }

    ///查找离得最近的VC
    open func findViewController()->UIViewController? {
        var next:UIResponder? = self.next
        while next != nil && !(next! is UIViewController) {
            next = next?.next
        }
        return next as? UIViewController
    }

    ///根据当前的条件增加或者删除对ViewController的观察者
    open func updateViewControllerTitleObserver() {
        if let viewController = self.findViewController(), self.observeViewControllerTitle {
            if viewController != self.viewController_weak {
                //不是同一个VC
                viewController_weak?.removeObserver(self, forKeyPath: #keyPath(UIViewController.title), context: &self.viewControllerObserverContext)
                viewController.addObserver(self, forKeyPath: #keyPath(UIViewController.title), options: .new, context: &self.viewControllerObserverContext)
                self.viewController_weak = viewController
            }
        }else {
            //被移走了,或者观察title功能被禁用, 删除观察者
            viewController_weak?.removeObserver(self, forKeyPath: #keyPath(UIViewController.title), context: &self.viewControllerObserverContext)
            viewController_weak = nil
        }
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &self.viewControllerObserverContext {
            if let inVC = object as? UIViewController, inVC == self.viewController_weak, keyPath == #keyPath(UIViewController.title) {
                self.setTitle(inVC.title)
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}

extension RXCFakeNavigationBar {

    ///透明效果View的封装
    public class TranslucentVisualEffectView: UIVisualEffectView {

        ///一个半透明的View, 带有一些半透明效果, iOS13上是这么设计的
        internal var colorAlphaView:UIView?
        ///真的显示barTint的View
        internal var colorView:UIView?

        internal override init(effect: UIVisualEffect?) {
            super.init(effect: effect)
            self.initSetupSubviews()
        }

        internal required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.initSetupSubviews()
        }

        internal func initSetupSubviews() {
            self.colorAlphaView?.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 0.50)
            //self.contentView.addSubview(self.colorAlphaView)
            //self.contentView.addSubview(self.colorView)
        }

        public override func layoutSubviews() {
            super.layoutSubviews()
            self.colorAlphaView?.frame = self.contentView.bounds
            self.colorView?.frame = self.contentView.bounds
        }

        internal func setBarTintColor(_ color:UIColor?) {
            if color == nil {
                //如果不显示颜色, 则不添加view
                self.colorAlphaView?.removeFromSuperview()
                self.colorView?.removeFromSuperview()
            }else {
                //添加显示颜色的View
                if self.colorAlphaView == nil {
                    self.colorAlphaView = UIView()
                    self.colorAlphaView?.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 0.50)
                }
                if self.colorAlphaView?.superview == nil {
                    self.contentView.addSubview(self.colorAlphaView!)
                }
                if self.colorView == nil {
                    self.colorView = UIView()
                    self.colorView?.alpha = 0.85
                }
                if self.colorView?.superview == nil {
                    self.contentView.addSubview(self.colorView!)
                }
                self.colorView?.backgroundColor = color
            }
        }

    }

}

