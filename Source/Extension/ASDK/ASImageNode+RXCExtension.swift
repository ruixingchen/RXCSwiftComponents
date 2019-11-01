//
//  ASImageNode+RXCExtension.swift
//  SampleProject
//
//  Created by ruixingchen on 3/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public extension ASImageNode {

    ///setter will set tine color and getter always returns nil
    var rxc_tintColor:UIColor? {
        get {return nil}
        set {
            if let color = newValue {
                self.imageModificationBlock = ASImageNodeTintColorModificationBlock(color)
            }else{
                self.imageModificationBlock = nil
            }
        }
    }

}
