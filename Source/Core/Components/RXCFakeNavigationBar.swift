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

    var leftButtons:[UIButton] = []
    var rightButtons:[UIButton] = []

    internal var _titleLabel:UILabel?
    open var titleLabel:UILabel {
        if self._titleLabel == nil {
            self._titleLabel = UILabel()
        }
        return _titleLabel!
    }

    open override func layoutSubviews() {
        super.layoutSubviews()



    }


}
