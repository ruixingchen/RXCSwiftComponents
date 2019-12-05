//
//  RXCHTTPMethod+Alamofire.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 12/2/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
#if canImport(Alamofire)
import Alamofire
#endif

extension RXCHTTPMethod {

    public func toAlamofireHTTPMethod()->HTTPMethod {
        return HTTPMethod(rawValue: self.rawValue)!
    }

}
