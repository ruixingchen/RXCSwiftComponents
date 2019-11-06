//
//  RXCCenterButtonTabBar.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/6/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///中间显示一个按钮的TabBar, 只支持偶数个VC
open class RXCCenterButtonTabBar: UITabBar {

    public enum CenterButtonPosition {
        ///中间居中并且附加一个偏移量
        case centerY(CGFloat)
        ///顶部对齐并附加一个偏移量(坐标初始值是1, 想要真的对齐, 需要传入-1)
        case top(CGFloat)
        ///自定义布局
        case custom((UIView)->Void)
    }

    open internal(set) var centerButton:UIView?

    open var centerButtonPosition:CenterButtonPosition = .centerY(0.0)

    ///想要自定义的布局可以设置这个值, 数组是当前所有的subviews, 第二个参数是centerButton
    open var layoutSubviewsClosure:(([UIView], UIView?)->Void)?

    public init(button:UIView?) {
        self.centerButton = button
        super.init(frame: CGRect.zero)
        if let button = self.centerButton {
            self.addSubview(button)
        }
    }

    public required init?(coder: NSCoder) {
        guard let button = coder.decodeObject(forKey: "centerButton") as? UIView else {return nil}
        self.centerButton = button
        super.init(coder: coder)
        if let button = self.centerButton {
            self.addSubview(button)
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        //系统的布局规律:
        //左右留下2点空隙
        //所有的按钮间隔4点均分宽度

        if let closure = self.layoutSubviewsClosure {
            closure(self.subviews, self.centerButton)
            return
        }
        guard let _centerButton = self.centerButton else {return}
        if _centerButton.frame == CGRect.zero {
            _centerButton.sizeToFit()
        }

        guard let buttonClass = NSClassFromString("UITabBarButton") else {return}
        let buttons:[UIView] = self.subviews.filter({$0.isKind(of: buttonClass)})
        assert(buttons.count.isMultiple(of: 2), "当前只支持偶数个控制器")

        let buttonWidth = (self.bounds.width - 4 - CGFloat(buttons.count)*4 - _centerButton.frame.width)/CGFloat(buttons.count)

        //开始计算系统按钮的位置
        for i in buttons.enumerated() {
            let x:CGFloat

            if i.offset < buttons.count/2 {
                //左边的按钮
                x = 2 + 4*CGFloat(i.offset) + buttonWidth*CGFloat(i.offset)
            }else {
                //右边的按钮
                x = 2 + 4*CGFloat(i.offset+1) + buttonWidth*CGFloat(i.offset) + _centerButton.frame.width
            }
            i.element.frame = CGRect(x: x, y: i.element.frame.origin.y, width: buttonWidth, height: i.element.frame.height)
        }

        let x = (self.bounds.width-_centerButton.frame.width)/2
        switch self.centerButtonPosition {
        case .centerY(let offset):
            var centerY:CGFloat!// = buttons.first?.center.y
            if centerY == nil {
                let bottomInset:CGFloat
                if #available(iOS 11, *) {
                    bottomInset = self.safeAreaInsets.bottom
                }else {
                    ///iOS11以下的硬件也没有底部的安全区域, 直接设置成0即可
                    bottomInset = 0
                }
                centerY = (self.bounds.height - bottomInset)/2
            }
            let frame = CGRect(x: x, y: centerY+offset-_centerButton.frame.height/2, width: _centerButton.frame.width, height: _centerButton.frame.height)
            _centerButton.frame = frame
        case .top(let offset):
            let frame = CGRect(x: x, y: 1+offset, width: _centerButton.frame.width, height: _centerButton.frame.height)
            _centerButton.frame = frame
        case .custom(let closure):
            closure(_centerButton)
        }
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let button = self.centerButton {
            let converted = button.convert(point, from: self)
            if button.bounds.contains(converted) {
                return self.centerButton
            }else {
                return super.hitTest(point, with: event)
            }
        }else {
            return super.hitTest(point, with: event)
        }
    }

}
