//
//  RXCMultipartFormDataSpec.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/4/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

///描述一个表单数据, 只存储数据的逻辑顺序, 不包括生成最终数据的代码
public final class RXCMultipartFormDataSpec {

    public class BodyPart {
        public fileprivate(set) var data:Data?
        public fileprivate(set) var fileURL:URL?
        public fileprivate(set) var name:String
        public fileprivate(set) var fileName:String?
        public fileprivate(set) var mimeType:String?

        fileprivate init(data:Data, name:String) {
            self.data = data
            self.name = name
        }

        fileprivate init(fileURL:URL, name:String) {
            self.fileURL = fileURL
            self.name = name
        }
    }

    public fileprivate(set) var bodyParts:[BodyPart] = []

    fileprivate func append(bodyPart:BodyPart) {
        self.bodyParts.append(bodyPart)
    }

    public func append(_ data: Data, withName name: String) {
        let part = BodyPart(data: data, name: name)
        self.append(bodyPart: part)
    }

    public func append(_ data: Data, withName name: String, mimeType: String) {
        let part = BodyPart(data: data, name: name)
        part.mimeType = mimeType
        self.append(bodyPart: part)
    }

    public func append(_ data: Data, withName name: String, fileName: String, mimeType: String) {
        let part = BodyPart(data: data, name: name)
        part.mimeType = mimeType
        part.fileName = fileName
        self.append(bodyPart: part)
    }

    public func append(_ fileURL: URL, withName name: String) {
        let part = BodyPart(fileURL: fileURL, name: name)
        self.append(bodyPart: part)
    }

    public func append(_ fileURL: URL, withName name: String, fileName: String, mimeType: String) {
        let part = BodyPart(fileURL: fileURL, name: name)
        part.mimeType = mimeType
        part.fileName = fileName
        self.append(bodyPart: part)
    }

}
