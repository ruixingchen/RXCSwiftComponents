//
//  UITableViewCell+IndexPath.swift
//  SampleProject
//
//  Created by ruixingchen on 1/19/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public extension UITableViewCell {

    ///find self's tableView just inside self

    func rxc_findTableView()->UITableView? {
        return self.findInNextResponderChain(reversed: false, match: {$0 is UITableView}) as? UITableView
    }

    ///find index dynamicly, only works when visible
    var rxc_get_indexPath:IndexPath? {
        return self.rxc_findTableView()?.indexPath(for: self)
    }

    ///通知TableView更新高度
    func rxc_tellTableViewUpdateHeight(layout:Bool=true, animated:Bool) {
        let closure:()->Void = {
            if layout {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            let _tableView = self.rxc_findTableView()
            _tableView?.beginUpdates()
            _tableView?.endUpdates()
        }

        if animated {
            closure()
        }else {
            UIView.performWithoutAnimation {
                closure()
            }
        }
    }

}
