//
//  RXCViewLikeObjectProtocol.swift
//  CoolMarket
//
//  Created by ruixingchen on 9/5/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

///使用协议来统一Node和UIView
public protocol RXCViewProtocol: AnyObject {

    var rsc_frame:CGRect {get set}
    var rsc_bounds:CGRect {get set}
    var rsc_backgroundColor:UIColor? {get set}
    var rsc_layer:CALayer {get}

    func rsc_view()->UIView
}
