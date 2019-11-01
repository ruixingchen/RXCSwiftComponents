import UIKit

public extension UIFont {

    ///标准字体的大小
    static var standardSize:CGFloat = 17

    static var p3:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize+3)}
    static var p2:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize+2)} //19
    static var p1:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize+1)} //18
    static var standard:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize)} //17
    static var n1:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-1)}
    static var n2:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-2)} //15
    static var n4:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-4)} //13
    static var n6:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-6)} //11
    static var n8:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-8)} //9
    static var n10:UIFont {return UIFont.systemFont(ofSize: UIFont.standardSize-10)} //7

    ///easy to remember for the olds like me, 😂
    func equalWidthDigit()->UIFont {
        return self.monospacedDigit()
    }

    func monospacedDigit()-> UIFont {
        let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = self.fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }

    private func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {return self}
        return UIFont(descriptor: descriptor, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

}
