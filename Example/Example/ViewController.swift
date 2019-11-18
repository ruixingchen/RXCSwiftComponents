//
//  ViewController.swift
//  Example
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCSwiftComponents

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let fakeBar = RXCFakeNavigationBar()
    let navBar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true

        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.navigationItem.leftBarButtonItems = (0..<2).map({_ in UIBarButtonItem(title: "呵呵", style: .plain, target: nil, action: nil)})
        self.navigationItem.rightBarButtonItems = (0..<2).map({_ in UIBarButtonItem(title: "呵呵", style: .plain, target: nil, action: nil)})
        self.title = "顶顶顶顶 哒哒哒哒哒哒多多多多多多多"
        self.fakeBar.setLeftButtons((0..<2).map({_ in let button = UIButton(type: .system); button.setTitle("呵呵", for: .normal); return button}))
        self.fakeBar.setRightButtons((0..<2).map({_ in let button = UIButton(type: .system); button.setTitle("呵呵", for: .normal); return button}))
        self.fakeBar.leftButtons.forEach({($0 as! UIButton).titleLabel?.font = UIFont.systemFont(ofSize: 17)})
        self.fakeBar.barBackgroundViewFillTopSpace = false
        self.fakeBar.setTitle("第一页")
        self.view.addSubview(self.fakeBar)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.frame = self.view.bounds
        if #available(iOS 11, *) {
            self.fakeBar.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.bounds.width, height: 44)
        }else {
            self.fakeBar.frame = CGRect(x: 0, y: self.topLayoutGuide.length, width: self.view.bounds.width, height: 44)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationController?.navigationBar.clipsToBounds = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = UIColor.random()
        cell.textLabel?.text = indexPath.row.description
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row%5 {
        case 0:
            let t = self.fakeBar.isTranslucent
            self.navigationController?.navigationBar.isTranslucent = !t
            self.fakeBar.isTranslucent = !t
        case 1:
            self.fakeBar.barTintColor = nil
            self.navigationController?.navigationBar.barTintColor = nil
        case 2:
            self.fakeBar.tintColor = UIColor.orange
        case 3:
            let num = (1..<100).randomElement()!
            self.title = (0..<num).map({_ in (0...9).randomElement()!.description}).joined()
        default:
//            let cell = tableView.cellForRow(at: indexPath)!
//            self.fakeBar.barTintColor = cell.contentView.backgroundColor
//            self.navigationController?.navigationBar.barTintColor = cell.contentView.backgroundColor
            let color = UIColor.random()
            self.fakeBar.barTintColor = color
            self.navigationController?.navigationBar.barTintColor = color
        }
    }

}

