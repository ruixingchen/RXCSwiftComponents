//
//  UITableView+RXCListViewProtocol.swift
//  RXCEntityListViewController
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public extension UICollectionView.ScrollPosition {
    func toTableViewScrollPosition()->UITableView.ScrollPosition {
        if self == .top {return .top}
        else if self == .centeredVertically || self == .centeredHorizontally {return .middle}
        else if self == .bottom {return .bottom}
        return .none
    }
}

extension UITableView: RXCListViewProtocol {

    public var rsc_numberOfSections: Int {
        return self.numberOfSections
    }

    public func rsc_numberOfRows(inSection section: Int) -> Int {
        return self.numberOfRows(inSection: section)
    }

    public func rsc_rectForRow(at indexPath: IndexPath) -> CGRect {
        return self.rectForRow(at: indexPath)
    }

    public func rsc_indexPathForRow(at point: CGPoint) -> IndexPath? {
        return self.indexPathForRow(at: point)
    }

    public func rsc_indexPath(for cell: AnyObject) -> IndexPath? {
        if let c = cell as? UITableViewCell {
            return self.indexPath(for: c)
        }
        return nil
    }

    public func rsc_cellForRow(at indexPath: IndexPath) -> AnyObject? {
        return self.cellForRow(at: indexPath)
    }

    public var rsc_visibleCells: [AnyObject] {
        return self.visibleCells
    }

    public var rsc_visibleIndexPaths: [IndexPath] {
        return self.indexPathsForVisibleRows ?? []
    }

    public func rsc_scrollToRow(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        return self.scrollToRow(at: indexPath, at: scrollPosition.toTableViewScrollPosition(), animated: animated)
    }

    public func rsc_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        if #available(iOS 11.0, *) {
            self.performBatchUpdates(updates, completion: completion)
        } else {
            self.beginUpdates()
            updates?()
            self.endUpdates()
            completion?(true)
        }
    }

    public func rsc_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.insertSections(sections, with: animation)
    }

    public func rsc_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.deleteSections(sections, with: animation)
    }

    public func rsc_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.reloadSections(sections, with: animation)
    }

    public func rsc_moveSection(_ section: Int, toSection newSection: Int) {
        self.moveSection(section, toSection: newSection)
    }

    public func rsc_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.insertRows(at: indexPaths, with: animation)
    }

    public func rsc_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.deleteRows(at: indexPaths, with: animation)
    }

    public func rsc_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.reloadRows(at: indexPaths, with: animation)
    }

    public func rsc_moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        self.moveRow(at: indexPath, to: newIndexPath)
    }

    public func rsc_reloadData() {
        self.reloadData()
    }

    public var rsc_allowsSelection: Bool {
        get {
            return self.allowsSelection
        }
        set {
            self.allowsSelection = newValue
        }
    }

    public var rsc_allowsMultipleSelection: Bool {
        get {
            return self.allowsMultipleSelection
        }
        set {
            self.allowsMultipleSelection = newValue
        }
    }

    public var rsc_indexPathForSelectedRow: IndexPath? {
        return self.indexPathForSelectedRow
    }

    public var rsc_indexPathsForSelectedRows: [IndexPath] {
        return self.indexPathsForSelectedRows ?? []
    }

    public func rsc_selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        self.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition.toTableViewScrollPosition())
    }

    public func rsc_deselectRow(at indexPath: IndexPath, animated: Bool) {
        self.deselectRow(at: indexPath, animated: animated)
    }

}
