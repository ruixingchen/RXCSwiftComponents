//
//  RXCMultipartFormDataSpec+Alamofire.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
#if canImport(Alamofire)
import Alamofire

extension RXCMultipartFormDataSpec {

    func toAlamofireMultipartFormData()->Alamofire.MultipartFormData {
        let data = Alamofire.MultipartFormData()
        data.append(multipartForm: self)
        return data
    }

}
#endif
