//
//  URLComponents+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/8/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public extension URLComponents {

    /// 追加query
    /// - Parameter items: 要追加的query
    /// - Parameter allowDuplication: 是否允许重复, 不允许的话新的值将会替换旧的值
    @available(iOS 8.0, *)
    mutating func appendQueryItems<C:Collection>(_ items:C, allowDuplication:Bool=false) where C.Element==URLQueryItem {
        var oldItems:[URLQueryItem] = self.queryItems ?? []
        if !allowDuplication {
            let allNewName:[String] = items.map({$0.name})
            oldItems = oldItems.filter({!allNewName.contains($0.name)})
        }
        oldItems.append(contentsOf: items)
        self.queryItems = oldItems
    }

    func getQuery(name:String)->String? {
        return self.queryItems?.filter({$0.name==name}).first?.value
    }

    ///有这个字段则更新字段, 否则添加这个字段
    mutating func setQuery(name:String, value:String?) {
        if var queryItems = self.queryItems {
            for i in queryItems.enumerated() {
                if i.element.name == name {
                    queryItems[i.offset] = URLQueryItem(name: name, value: value)
                }
            }
            self.queryItems = queryItems
        }else {
            //没有query部分, 添加
            let item = URLQueryItem(name: name, value: value)
            self.queryItems = [item]
        }
    }

    mutating func removeQuery(name:String) {
        guard let items = self.queryItems else {return}
        self.queryItems = items.filter({ $0.name != name })
    }

    subscript(queryName:String)->String? {
        get {
            return getQuery(name: queryName)
        }
        set {
            self.setQuery(name: queryName, value: newValue)
        }
    }

}
