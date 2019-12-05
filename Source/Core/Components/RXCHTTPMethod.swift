//
//  RXCHTTPMethods.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 12/2/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

///代码是直接拷贝Alamofire的
public enum RXCHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
