//
//  RXCListViewProtocol.swift
//  RXCEntityListViewController
//
//  Created by ruixingchen on 9/15/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

///将所有列表视图的API进行统一
public protocol RXCListViewProtocol: RXCScrollViewProtocol {

    var rsc_numberOfSections: Int { get }

    func rsc_numberOfRows(inSection section: Int) -> Int

    func rsc_rectForRow(at indexPath: IndexPath) -> CGRect

    func rsc_indexPathForRow(at point: CGPoint) -> IndexPath?

    func rsc_indexPath(for cell: AnyObject) -> IndexPath?

    func rsc_cellForRow(at indexPath: IndexPath) -> AnyObject?

    var rsc_visibleCells: [AnyObject] { get }

    var rsc_visibleIndexPaths: [IndexPath] { get }

    func rsc_scrollToRow(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool)

    // Reloading and Updating

    func rsc_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?)

    func rsc_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)

    func rsc_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)

    func rsc_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)

    func rsc_moveSection(_ section: Int, toSection newSection: Int)

    func rsc_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)

    func rsc_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)

    func rsc_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)

    func rsc_moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)

    func rsc_reloadData()

    var rsc_allowsSelection: Bool {get set}

    @available(iOS 5.0, *)
    var rsc_allowsMultipleSelection: Bool {get set}

    // Selection

    var rsc_indexPathForSelectedRow: IndexPath? { get }

    @available(iOS 5.0, *)
    var rsc_indexPathsForSelectedRows: [IndexPath] { get }

    func rsc_selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition)

    func rsc_deselectRow(at indexPath: IndexPath, animated: Bool)

}
