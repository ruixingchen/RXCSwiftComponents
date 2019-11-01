//
//  RXCMessagedError.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

///一个可以容纳一些字符串信息的Error对象
public struct RXCMessagedError: LocalizedError, CustomStringConvertible, CustomDebugStringConvertible {

    public var message: String
    public var debugMessage: String?
    public var userInfo:[AnyHashable:Any]?

    public var errorDescription: String? {
        return self.message
    }

    public var description: String {
        return self.message
    }

    public var debugDescription: String {
        return "message: \(self.message)\ndebugMessage: \(self.debugMessage ?? "nil")\nuserInfo: \(self.userInfo?.debugDescription ?? "nil")"
    }

    public init(message:String) {
        self.message = message
    }

    public init(message:String, debugMessage:String?) {
        self.message = message
        self.debugMessage = debugMessage
    }

}

