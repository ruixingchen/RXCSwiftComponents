//
//  MultipartFormData+RXCMultipartFormDataSpec.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
#if canImport(Alamofire)
import Alamofire

extension MultipartFormData {

    public func append(multipartForm: RXCMultipartFormDataSpec) {
        for i in multipartForm.bodyParts {
            if let data = i.data {
                //we have data
                if i.fileName != nil && i.mimeType != nil {
                    self.append(data, withName: i.name, fileName: i.fileName!, mimeType: i.mimeType!)
                }else if i.mimeType != nil {
                    self.append(data, withName: i.name, mimeType: i.mimeType!)
                }else {
                    self.append(data, withName: i.name)
                }
            }else if let url = i.fileURL {
                //file url
                if i.fileName == nil && i.mimeType == nil {
                    self.append(url, withName: i.name, fileName: i.fileName!, mimeType: i.mimeType!)
                }else {
                    self.append(url, withName: i.name)
                }
            }
        }
    }

}


#endif
