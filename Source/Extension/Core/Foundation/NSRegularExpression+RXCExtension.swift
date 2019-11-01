//
//  NSRegularExpression+Extension.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/12/18.
//  Copyright © 2018 CoolApk. All rights reserved.
//

import Foundation

public extension NSRegularExpression {

    ///传入的字符串是否匹配本正则
    func isMatched(_ str: String) -> Bool {
        return self.firstMatch(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: str.count)) != nil
    }

}
