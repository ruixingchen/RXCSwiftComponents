//
//  RXCBindableObject.swift
//  CoolMarket
//
//  Created by ruixingchen on 10/16/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

///描述一个可以进行数据绑定的对象, 只规定绑定方法, 不规定Model的接口
public protocol RXCBindableObjectProtocol {

    func rxc_bindData(data:Any?, userInfo:[AnyHashable:Any]?)

}

///描述一个可以绑定数据, 同时对外有一个获取已绑定数据的接口的对象
public protocol RXCBindableModelStorageObjectProtocol: RXCBindableObjectProtocol {

    var rxc_bindedEntity:Any? {get}

}
