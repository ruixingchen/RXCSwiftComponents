//
//  RXCParserProtocol.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

///描述一个解析器, 可以将一种数据解析成另一种数据
public protocol RXCParserProtocol {

    func parse<T>(object:Any?, userInfo:[AnyHashable:Any]?)->Swift.Result<T, Error>

}

//pass a closure to parse data
public struct RXCAnyParser<R>: RXCParserProtocol {

    private let closure:(Any?)->Swift.Result<R, Error>

    init(closure:@escaping (Any?)->Swift.Result<R, Error>) {
        self.closure = closure
    }

    public func parse<T>(object: Any?, userInfo: [AnyHashable : Any]?) -> Result<T, Error> {
        let result = closure(object)
        do {
            if let cast = (try result.get()) as? T {
                return Result.success(cast)
            }else {
                throw RXCMessagedError(message: "parsing object successfully but with a wrong result type, casting failed", debugMessage: "expected:\(T.self), got:\(R.self)")
            }
        }catch {
            return Result.failure(error)
        }
    }

}
