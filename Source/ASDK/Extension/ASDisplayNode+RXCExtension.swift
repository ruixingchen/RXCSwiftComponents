//
//  ASDisplayNode+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/6/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation
#if canImport(AsyncDisplayKit)
import AsyncDisplayKit
#endif

#if canImport(AsyncDisplayKit)
public extension ASDisplayNode {

    static func layerBacked(color:UIColor)->ASDisplayNode {
        let node = ASDisplayNode()
        if node.supportsLayerBacking {node.isLayerBacked = true}
        node.backgroundColor = color
        return node
    }

    @discardableResult
    func layerBackedIfSupported()->Self {
        if self.supportsLayerBacking {
            self.isLayerBacked = true
        }
        return self
    }

    func addSubnodeOptionally(_ node:ASDisplayNode?){
        if node == nil {return}
        self.addSubnode(node!)
    }

    func closestView()->UIView? {
        // Careful not to trigger node loading here.
        if (!self.isNodeLoaded) {
            return nil
        }

        guard let view: UIView = ASFindClosestViewOfLayer(self.layer) else {return nil}
        return view
    }

}
#endif
