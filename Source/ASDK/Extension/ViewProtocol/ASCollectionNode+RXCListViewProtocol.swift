//
//  ASCollectionNode+RXCListViewProtocol.swift
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
extension ASCollectionNode: RXCListViewProtocol {

    public var rsc_numberOfSections: Int {
        return self.numberOfSections
    }

    public func rsc_numberOfRows(inSection section: Int) -> Int {
        return self.numberOfItems(inSection: section)
    }

    public func rsc_rectForRow(at indexPath: IndexPath) -> CGRect {
        guard let cell = self.nodeForItem(at: indexPath) else {return CGRect.zero}
        return cell.frame
    }

    public func rsc_indexPathForRow(at point: CGPoint) -> IndexPath? {
        return self.indexPathForItem(at: point)
    }

    public func rsc_indexPath(for cell: AnyObject) -> IndexPath? {
        if let c = cell as? ASCellNode {
            return self.indexPath(for: c)
        }
        return nil
    }

    public func rsc_cellForRow(at indexPath: IndexPath) -> AnyObject? {
        return self.cellForItem(at: indexPath)
    }

    public var rsc_visibleCells: [AnyObject] {
        return self.visibleNodes
    }

    public var rsc_visibleIndexPaths: [IndexPath] {
        return self.indexPathsForVisibleItems
    }

    public func rsc_scrollToRow(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        self.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    public func rsc_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        self.performBatchUpdates(updates, completion: completion)
    }

    public func rsc_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.insertSections(sections)
    }

    public func rsc_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.deleteSections(sections)
    }

    public func rsc_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.reloadSections(sections)
    }

    public func rsc_moveSection(_ section: Int, toSection newSection: Int) {
        self.moveSection(section, toSection: newSection)
    }

    public func rsc_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.insertItems(at: indexPaths)
    }

    public func rsc_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.deleteItems(at: indexPaths)
    }

    public func rsc_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.reloadItems(at: indexPaths)
    }

    public func rsc_moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        self.moveItem(at: indexPath, to: newIndexPath)
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
        return self.indexPathsForSelectedItems?.first
    }

    public var rsc_indexPathsForSelectedRows: [IndexPath] {
        return self.indexPathsForSelectedItems ?? []
    }

    public func rsc_selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        self.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }

    public func rsc_deselectRow(at indexPath: IndexPath, animated: Bool) {
        self.deselectItem(at: indexPath, animated: animated)
    }
}
#endif
