//
//  Data+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
import CommonCrypto

public extension Data {

    ///返回常见的mineType
    var mineType:String? {
        var b:UInt8 = 0
        self.copyBytes(to: &b, count: 1)
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            //return "application/octet-stream"
            return nil
        }
    }

    func rxc_md5()->Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    //deprecated in iOS 13
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }

    func rxc_md5Hex()->String {
        return self.rxc_md5().map { String(format: "%02hhx", $0) }.joined()
    }

    func rxc_md5Base64()->String {
        return self.rxc_md5().base64EncodedString()
    }

}
