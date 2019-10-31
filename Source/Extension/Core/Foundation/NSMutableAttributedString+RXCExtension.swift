//
//  NSMutableAttributedString.swift
//  CoolMarket
//
//  Created by ruixingchen on 2/26/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {

    /*
    /// 删除富文本两头的符合要求的字符
    ///
    /// - Parameter characterSet: 字符集
    func trimCharactersInSet(characterSet: CharacterSet=CharacterSet.whitespacesAndNewlines) {
        //先从后面开始搜索
        var subfixMatchedLength:Int = 0
        for i in (0..<self.length).reversed() {

            let subAtt = self.attributedSubstring(from: NSRange(location: i-1, length: 1))

        }

        let plainText: String = self.string
        var plainTextCount: Int = plainText.utf16Length //记录长度
        var matchCount: Int = 0
        //先计算尾部的, 再计算头部的,这样就不需要再获取一次string
        for i in 0..<plainTextCount {
            let sub: String = plainText.subString(from: plainTextCount-i-1, to: plainTextCount-i)
            if let scalar: Unicode.Scalar = Unicode.Scalar.init(sub) {
                if characterSet.contains(scalar) {
                    matchCount += 1
                } else {
                    break
                }
            } else {
                //字符转换失败, 也删掉
                matchCount += 1
            }
        }
        if matchCount != 0 {
            //尾部需要截去一段
            self.replaceCharacters(in: NSRange(location: plainTextCount-matchCount, length: matchCount), with: "")
            plainTextCount -= matchCount //记录的长度需要减少
        }
        matchCount = 0
        for i in 0..<plainTextCount {
            let sub: String = plainText.subString(from: i, to: i+1)
            if let scalar: Unicode.Scalar = Unicode.Scalar.init(sub) {
                if characterSet.contains(scalar) {
                    matchCount += 1
                } else {
                    break
                }
            } else {
                //字符转换失败, 也删掉
                matchCount += 1
            }
        }
        if matchCount != 0 {
            self.replaceCharacters(in: NSRange(location: 0, length: matchCount), with: "")
        }
    }
     */

    /// 对超出的字符使用...来代替
    func trunction(maxLength: Int) -> NSMutableAttributedString {
        if self.length <= maxLength {
            return self
        }
        self.replaceCharacters(in: NSRange(location: maxLength, length: self.length-maxLength), with: "...")
        return self
    }

}
