//
//  Error+URLError.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/1/18.
//  Copyright © 2018 CoolApk. All rights reserved.
//

import Foundation

public extension Error {

    var isURLRequestCancelledError: Bool {
        let code = (self as NSError).code
        let domain = (self as NSError).domain
        return domain == URLError.errorDomain && code == URLError.cancelled.rawValue
    }

}
