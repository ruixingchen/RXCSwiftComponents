//
//  String+RXCExtension+MD5.swift
//  RXCSwiftComponents
//
//  Created by ruixingchen on 11/1/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {

    func rxc_md5()->Data {
        let data = self.data(using: .utf8)!
        return data.rxc_md5()
    }

    func rxc_md5Hex()->String {
        return self.rxc_md5().rxc_md5Hex()
    }

    func rxc_md5Base64()->String {
        return self.rxc_md5().rxc_md5Base64()
    }

}
