//
//  CharacterSet+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 10/8/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public extension CharacterSet {

    ///是否包含str中的全部字符 / str中的字符全部包括在当前set中
    func contains(allOf str:String)->Bool {
        for i in str {
            guard let scalar = Unicode.Scalar.init(i.description) else {return false}
            if !self.contains(scalar) {
                return false
            }
        }
        return true
    }

    ///是否包含str中的任意一个字符 / str中是否含有当前set中的字符
    func contains(anyOf str:String)->Bool {
        for i in str {
            guard let scalar = Unicode.Scalar.init(i.description) else {return false}
            if self.contains(scalar) {
                return true
            }
        }
        return false
    }

    ///返回所有简体和繁体汉字的Set
    static func allChinese()->NSMutableCharacterSet {
        return NSMutableCharacterSet(range: NSRange(location: 0x4e00, length: 0x9fa5 - 0x4e00))
    }

}
