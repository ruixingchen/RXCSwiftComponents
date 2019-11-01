//
//  ASCellNode+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 4/4/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public extension ASCellNode {

    ///通过让separator缩进的方式来隐藏(4K分辨率下都有效)
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 4096, bottom: 0, right: 0)
    }

    ///查找当前separatorView的指针
    func separatorView()->UIView? {
        return nil
    }

}
