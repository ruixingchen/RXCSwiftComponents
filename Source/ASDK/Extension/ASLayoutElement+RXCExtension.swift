//
//  ASLayoutElement+QuickLayout.swift
//  CoolMarket
//
//  Created by ruixingchen on 4/15/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import AsyncDisplayKit

public extension ASLayoutElement {

    func insetLayout(insets:UIEdgeInsets)->ASInsetLayoutSpec {
        return ASInsetLayoutSpec(insets: insets, child: self)
    }

    func wrapperLayout()->ASWrapperLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: self)
    }

}
