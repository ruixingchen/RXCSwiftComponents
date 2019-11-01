//
//  ASTableNode+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 7/31/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

#if canImport(AsyncDisplayKit)
import AsyncDisplayKit

public extension ASTableNode {

    func checkForBatchFetch() {
        if self.view.responds(to: Selector(("_checkForBatchFetching"))) {
            self.view.perform(Selector(("_checkForBatchFetching")))
        }
    }

    func beginBatchFetching() {
        if self.view.responds(to: Selector(("_beginBatchFetching"))) {
            self.view.perform(Selector(("_beginBatchFetching")))
        }
    }

}

#endif
