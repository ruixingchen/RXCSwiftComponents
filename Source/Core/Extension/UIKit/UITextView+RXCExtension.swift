//
//  UITextView+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 6/14/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

public extension UITextView {

    /// 判断ShouldChangeText代理方法中的变化是不是键盘的退格操作
    ///
    /// - Parameters:
    ///   - textView: 要判断的TextView
    ///   - range: 发生改变的范围
    ///   - replacementText: 替换的文本
    static func isDeleteBackwordOnShouldChangeText(selectedRange:NSRange, range:NSRange, replacementText:String)->Bool {
        //没有进行选择
        //退格操作的主要特征:
        //1, 没有选择范围
        //2: range的length为 1
        //3: replacementText 为空字符串
        //4: 删除的位置在光标前面

        guard selectedRange.length == 0 else {return false}
        guard range.length == 1 else {return false}
        guard replacementText.isEmpty else {return false}

        if range.location == selectedRange.location-1 {
            //正常的退格操作
            return true
        }else if (selectedRange.location==0 && selectedRange.length==0) && (range.location==0&&range.length==0) {
            //在没有文本的时候执行退格操作
            return true
        }
        return false
    }

}

public extension UITextView {

    ///如果不layout获取到的值可能不正确
    func cursorFrame(layout:Bool = true)->CGRect? {
        guard let textPosition:UITextPosition = self.selectedTextRange?.end else {return nil}
        if layout {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        let cursorFrame:CGRect = self.caretRect(for: textPosition)
        return cursorFrame
    }

    ///如果不layout获取到的值可能不正确
    func selectedTextFrameStart(layout:Bool = true)->CGRect? {
        guard let range = self.selectedTextRange else {return nil}
        if layout {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        let position:UITextPosition = range.start
        let cursorFrame:CGRect = self.caretRect(for: position)
        return cursorFrame
    }

    ///如果不layout获取到的值可能不正确
    func selectedTextFrameEnd(layout:Bool = true)->CGRect? {
        guard let range = self.selectedTextRange else {return nil}
        if layout {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        let position:UITextPosition = range.end
        let cursorFrame:CGRect = self.caretRect(for: position)
        return cursorFrame
    }

    ///是否有高亮的标记文本, 比如输入中文的时候输入的拼音部分
    func hasHighlightMarkedText()->Bool {
        if let markedRange = self.markedTextRange, self.position(from: markedRange.start, offset: 0) != nil {
            return true
        }
        return false
    }

    ///标记部分的长度
    func markedTextTextRange()->NSRange? {
        if let markedRange = self.markedTextRange, let startPosition = self.position(from: markedRange.start, offset: 0), let endPosition = self.position(from: markedRange.end, offset: 0) {
            let beginning = self.beginningOfDocument
            let location = self.offset(from: beginning, to: startPosition)
            let length = self.offset(from: startPosition, to: endPosition)
            return NSRange(location: location, length: length)
        }
        return nil
    }

    ///返回删除了markedRange部分的文本
    func attributedTextExcludeMarkedRange()-> NSAttributedString? {
        guard let text = self.attributedText else {return nil}
        if let markedRange = self.markedTextTextRange() {
            return text.attributedSubstring(from: NSRange(location: 0, length: markedRange.location))
        }
        return text
    }

    ///当前的改变是否能在限制字数的条件下发生
    ///
    /// - Parameters:
    ///   - textView: 要操作的TextView
    ///   - range: 改变的范围
    ///   - text: 要改变的文字
    ///   - limit: 要限制的字数
    ///   - allowMarked: 是否允许高亮部分超过限制,如果为true, 则默认返回true, false适用于强制不允许TextView超过某个尺寸的场景
    @available(iOS, introduced: 8, deprecated: 8, message: "最好不要在shouldChange里面判断, 应该在用户输入完成之后再删除超过限制的部分, 否则可能导致用户无法粘贴长文本")
    static func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String, limit:Int, allowMarked:Bool) -> Bool {
        if text.count == 0 {
            //删除操作无论什么时候都允许
            return true
        }
        //这里如果当前没有mark部分是不起作用的, 但是如果没有mark部分, 且后面返回了false, 表示当前已经超过了限制, 不允许再进行输入的逻辑也是合理的
        if allowMarked && textView.hasHighlightMarkedText() {
            //如果用户正在进行拼音输入, 直接放行
            return true
        }
        return (textView.attributedText?.length ?? 0) + text.utf16.count - range.length <= limit
    }

    ///检查TextView的字数, 如果超过了限制, 删除超过的部分
    ///
    /// - Parameters:
    ///   - textView: 要执行操作的textView
    ///   - limit: 限制的字数
    ///   - allowMarked: 是否允许marked部分超过限制, 如果为true, 则含有marked部分的时候不会执行任何操作, 默认为true
    ///   - callDelegate: 是否通知代理textViewDidChange, 默认通知
    /// - Returns: 是否成功执行了删除文本
    @discardableResult
    static func checkTextLengthLimit(textView:UITextView, limit:Int, allowMarked:Bool=true, callDelegate:Bool=true)->Bool {
        if allowMarked && textView.hasHighlightMarkedText() {
            return false
        }

        var limit = limit
        if limit < 0 {
            limit = 0
        }

        let text:NSMutableAttributedString = textView.attributedText?.toMutable() ?? NSMutableAttributedString()
        if text.length > limit {
            text.deleteCharacters(in: NSRange(location: limit+1, length: text.length-limit))

            var selectedRange = textView.selectedRange
            selectedRange.length = 0

            textView.attributedText = text

            if selectedRange.location > text.length {
                selectedRange.location = text.length
            }
            textView.selectedRange = selectedRange
            if callDelegate {
                textView.delegate?.textViewDidChange?(textView)
            }
            return true
        }
        return false
    }

}
