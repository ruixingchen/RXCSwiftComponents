//
//  String+RXCExtension.swift
//  RXCSwiftExtension
//
//  Created by ruixingchen on 1/28/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public extension StringProtocol {

    var string:String {return String(self)}

    var int:Int? {return Int(self)}
    var double:Double? {return Double(self)}
    var float:Float? {return Float(self)}

}

public extension String {

    ///一个emoji算作一个count, 正常情况下应该使用这个来计算长度
    var length:Int {
        return self.utf16.count
    }

    ///将一个NSRange转换为Swift.Range
    func rangeFromNSRange(_ nsRange: NSRange) -> Range<String.Index> {
        let utf16 = self.utf16
        let low = utf16.index(utf16.startIndex, offsetBy: nsRange.location)
        let up = utf16.index(low, offsetBy: nsRange.length)
        return low..<up
    }

    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    ///如果是empty的, 则转换为nil
    func emptyToNil()->String? {
        if self.isEmpty {return nil}
        return self
    }

    ///如果是blank的, 则转换为nil
    func blankToNil()->String? {
        if self.isBlank {return nil}
        return self
    }

    func trimming(in characterSet:CharacterSet)->String {
        return self.trimmingCharacters(in: characterSet)
    }

    mutating func trimmed(characterSet:CharacterSet=CharacterSet.whitespacesAndNewlines) {
        self = self.trimmingCharacters(in: characterSet)
    }

    ///将本字符串中Set中的所有字符替换为传入的字符串
    func replacingCharactersFromSet(characterSet: CharacterSet,with replacementString: String) -> String {
        return self.components(separatedBy: characterSet).joined(separator: replacementString)
    }

    //MARK: - Substring

    subscript (range: NSRange)->String {
        let low = self.index(self.startIndex, offsetBy: range.lowerBound)
        let up = self.index(self.startIndex, offsetBy: range.upperBound)
        let substring = self[low..<up]
        return String(substring)
    }

    subscript(integerRange: Range<Int>) -> String {
        let low = self.index(self.startIndex, offsetBy: integerRange.lowerBound)
        let up = self.index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[low..<up])
    }

    subscript(integerClosedRange: ClosedRange<Int>) -> String {
        let low = self.index(self.startIndex, offsetBy: integerClosedRange.lowerBound)
        let up = self.index(startIndex, offsetBy: integerClosedRange.upperBound)
        return String(self[low...up])
    }

    //MARK:  - EZ

    /// EZSE: Init string with a base64 encoded string
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.count % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }

    ///将这个base64字符串转换为正常的字符串
    func fromBase64()->String? {
        return String(base64: self)
    }

    /// EZSE: base64 encoded of string
    func base64Encoded()-> String {
        let plainData = self.data(using: .utf8)!
        let base64String = plainData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

    ///抓换成URL
    func toURL()->URL? {
        var url:URL? = URL(string: self)
        if url == nil {
            url = URL(string: self.urlEncoded())
        }
        return url
    }

    ///if marked safe, will decode and encode
    func urlEncoded(safe:Bool=true) throws -> String {
        //为了防止URL被多次转码解码, 如果标记为safe, 则会先完全解码之后再转码
        let text:String
        if safe {
            let decoded = self.urlDecoded(loop: true)
            precondition(<#T##condition: Bool##Bool#>, <#T##message: String##String#>)
            text = decoded!
        }else{
            text = self
        }
        //这里一定要用urlQueryAllowed, 否则可能解析错误或者失败
        return text.addingPercentEncoding(withAllowedCharacters:
            CharacterSet.urlQueryAllowed) ?? ""
    }

    /// URL解码
    ///
    /// - Parameter loop: 是否循环解码, 不循环的话只会解码一次
    func urlDecoded(loop:Bool=true) -> String? {
        if !loop {
            let decoded:String? = self.removingPercentEncoding
            assert(decoded != nil, "字符串URL解码失败:\(self)")
            return decoded
        }else{
            //循环解码, 直到解码后的字符串和解码前的字符串相等
            var before:String = self
            var after = before.removingPercentEncoding
            while (after != nil && after != before) {
                before = after!
                after = before.removingPercentEncoding
            }
            return after
        }
    }

    func reversedString() -> String {
        return String(self.reversed())
    }

    func subString(from: Int, to: Int) -> String {
        let range = Range(uncheckedBounds: (lower: self.utf16.index(self.utf16.startIndex, offsetBy: from), upper: self.utf16.index(self.utf16.startIndex, offsetBy: to)))
        let result = String.init(describing: self[range])
        return result
    }

    func subString(range:NSRange) -> String {
        return self.subString(from: range.lowerBound, to: range.upperBound)
    }

    #if canImport(CryptoSwift)
    var md5:String {
        return self.md5()
    }
    #else
    #if false
    func md5() -> String {
        let string = self
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format: "%02x", byte)
        }

        return hexString
    }
    #endif
    #endif

    var isNotEmpty:Bool {
        return !self.isEmpty
    }

    var isNotBlank:Bool {
        return !self.isBlank
    }

    func lineBreakerToSpace()->String {
        return self.replacingOccurrences(of: "[\n\r]", with: " ", options: String.CompareOptions.regularExpression, range: nil)
    }

}
