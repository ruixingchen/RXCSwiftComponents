//
//  UINavigationBar+RXCExtension.swift
//  ruixingchen
//
//  Created by ruixingchen on 1/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public extension UINavigationBar {

    var rxc_hairLine:UIImageView? {
        func rxc_findHairLine(view:UIView)->UIImageView? {
            if view is UIImageView && view.frame.height < 1 {
                return view as? UIImageView
            }else{
                for i in view.subviews {
                    if let line = rxc_findHairLine(view: i) {
                        return line
                    }
                }
            }
            return nil
        }
        return rxc_findHairLine(view: self)
    }

    var barBackground:UIView? {
        if let classs = NSClassFromString("_UIBarBackground"), let view = self.subviews.first, view.isKind(of: classs) {
            return view
        }
        return nil
    }

}
