//
//  ASTextNode+Label.swift
//  CoolMarket
//
//  Created by ruixingchen on 4/12/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import AsyncDisplayKit

public extension ASTextNode {

    ///行数限制
    var numberOfLines:Int {
        get {
            return self.maximumNumberOfLines.int
        }
        set {
            self.maximumNumberOfLines = UInt(newValue)
        }
    }

    ///字体
    private var _font:UIFont? {
        get {
            return objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_font".hashValue)!) as? UIFont
        }
        set {
            objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_font".hashValue)!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var font:UIFont {
        get {return self._font ?? UIFont.systemFont(ofSize: 17)}
        set {
            self._font = newValue
            self.reloadText()
        }
    }

    var _textColor:UIColor? {
        get {
            return objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_text_color".hashValue)!) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_text_color".hashValue)!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var textColor:UIColor {
        get {
            if let color = self._textColor {return color}
            if #available(iOS 13, *) {
                return UIColor.label
            }else {
                return UIColor.black
            }
        }
        set {
            self._textColor = newValue
            self.reloadText()
        }
    }

    var paragraphStyle:NSParagraphStyle? {
        get {
            return objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_paragraph_style".hashValue)!) as? NSParagraphStyle
        }
        set {
            objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: "rxc_extension_paragraph_style".hashValue)!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.reloadText()
        }
    }

    private var paragraphStyle_mutable:NSMutableParagraphStyle? {
        guard let p = self.paragraphStyle else {return nil}
        let mp:NSMutableParagraphStyle
        if let p_m = p as? NSMutableParagraphStyle {
            mp = p_m
        }else{
            mp = NSMutableParagraphStyle()
            mp.setParagraphStyle(p)
        }
        return mp
    }

    var textAlignment: NSTextAlignment {
        get {
            return paragraphStyle?.alignment ?? .left
        }
        set {
            let p = self.paragraphStyle_mutable ?? NSMutableParagraphStyle()
            p.alignment = newValue
            self.paragraphStyle = p
        }
    }

    var lineBreakMode:NSLineBreakMode {
        get {
            return self.paragraphStyle?.lineBreakMode ?? .byTruncatingTail
        }
        set {
            let p = self.paragraphStyle_mutable ?? NSMutableParagraphStyle()
            p.lineBreakMode = newValue
            self.paragraphStyle = p
        }
    }

    var text:String? {
        get {return self.attributedText?.string}
        set {
            guard let validText = newValue else {
                self.attributedText = nil
                return
            }
            self.attributedText = NSAttributedString(string: validText, attributes: self.rxc_attributes())
        }
    }

    ///returns the custom attributes, empty dict if no value if setted
    private func rxc_attributes()->[NSAttributedString.Key:Any] {
        var attributes:[NSAttributedString.Key:Any] = [:]
        attributes[NSAttributedString.Key.font] = self._font
        attributes[NSAttributedString.Key.foregroundColor] = self._textColor
        attributes[NSAttributedString.Key.paragraphStyle] = self.paragraphStyle
        return attributes
    }

    ///if some of the attributes is changed, we should refresh display
    private func reloadText(){
        if let att = self.attributedText {
            let attributes = self.rxc_attributes()
            let mAtt:NSMutableAttributedString = (att as? NSMutableAttributedString) ?? NSMutableAttributedString(attributedString: att)
            mAtt.addAttributes(attributes, range: NSRange(location: 0, length: mAtt.length))
            self.attributedText = mAtt
        }
    }

}

// MARK: - Link

extension ASTextNode {

    @discardableResult
    func font(_ object:UIFont)->Self {
        self.font = object
        return self
    }

    @discardableResult
    func textColor(_ object:UIColor)->Self {
        self.textColor = object
        return self
    }

    @discardableResult
    func textAlignment(_ object:NSTextAlignment)->Self {
        self.textAlignment = object
        return self
    }

    @discardableResult
    func lineBreakMode(_ object:NSLineBreakMode)->Self {
        self.lineBreakMode = object
        return self
    }

}
