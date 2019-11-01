//
//  ASDisplayNode+RXCViewProtocol.swift
//  RXCEntityListViewController
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
#if canImport(AsyncDisplayKit)
import AsyncDisplayKit
#endif

#if (CanUseASDK || canImport(AsyncDisplayKit))
extension ASDisplayNode: RXCViewProtocol {
    
    public var rsc_frame: CGRect {
        get {return self.frame}
        set {self.frame = newValue}
    }

    public var rsc_bounds: CGRect {
        get {return self.bounds}
        set {self.bounds = newValue}
    }

    public var rsc_backgroundColor: UIColor? {
        get {return self.backgroundColor}
        set {self.backgroundColor = newValue}
    }

    public var rsc_layer: CALayer {
        return self.layer
    }

    public func rsc_view() -> UIView {
        return self.view
    }

}
#endif
