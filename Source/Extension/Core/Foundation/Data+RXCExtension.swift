//
//  Data+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
#if canImport(CryptoSwift)
import CryptoSwift
#endif


public extension Data {

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

    #if canImport(CryptoSwift)
    var md5:String {
        let _md5 = self.md5().toHexString()
        return _md5
    }
    #endif

}
