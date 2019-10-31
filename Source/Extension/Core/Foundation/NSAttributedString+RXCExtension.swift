//
//  NSAttributedString+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 7/24/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public typealias ASAttributesDict = [NSAttributedString.Key:Any]

public extension NSAttributedString {

    /// 将不可变富文本转换为可变富文本
    ///
    /// - Parameter copy: 是否强制copy指针, 返回一个新的指针
    func toMutable(copy:Bool=false)->NSMutableAttributedString {
        if copy {
            return NSMutableAttributedString(attributedString: self)
        }
        if let m = self as? NSMutableAttributedString {return m}
        return NSMutableAttributedString(attributedString: self)
    }

    ///返回删除了两端符合字符集要求的富文本
    func trimmed(characterSet:CharacterSet=CharacterSet.whitespacesAndNewlines)->NSAttributedString {
        let att = NSMutableAttributedString(attributedString: self)
        //先从后面开始遍历
        if true {
            var lastMatchIndex:Int = -1
            for i in (0..<att.length).reversed() {
                let subAtt = self.attributedSubstring(from: NSRange(location: i, length: 1))
                let subStr = subAtt.string
                guard subStr.utf16Length > 0 else {
                    //无法获取字符串, 可能是一个表情或者其他数据, 判断为不符合要求, 停止遍历
                    break
                }
                if characterSet.contains(anyOf: subStr) {
                    //包含在字符集中, 继续遍历
                    lastMatchIndex = i
                }else {
                    break
                }
            }
            //删除后面的部分
            if lastMatchIndex >= 0 {
                att.deleteCharacters(in: NSRange(location: lastMatchIndex, length: att.length-lastMatchIndex))
            }
        }
        if true {
            var firstMatchIndex:Int = -1
            for i in (0..<att.length) {
                let subAtt = self.attributedSubstring(from: NSRange(location: i, length: 1))
                let subStr = subAtt.string
                guard subStr.utf16Length > 0 else {
                    //无法获取字符串, 可能是一个表情或者其他数据, 判断为不符合要求, 停止遍历
                    break
                }
                if characterSet.contains(anyOf: subStr) {
                    //包含在字符集中, 继续遍历
                    firstMatchIndex = i
                }else {
                    break
                }
            }
            //删除后面的部分
            if firstMatchIndex >= 0 {
                att.deleteCharacters(in: NSRange(location: 0, length: firstMatchIndex+1))
            }
        }
        return att
    }

}
