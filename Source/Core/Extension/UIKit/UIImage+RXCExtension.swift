//
//  UIImage+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/19/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

/*
 the tint funtion is from https://github.com/vilanovi/UIImage-Additions
 */
public extension UIImage {

    enum TintStyle {
        case keepAlpha
        case overAlpha
        case overAlphaExtreme
    }

    func tinted(color:UIColor, style:TintStyle)->UIImage?{
        let scale = self.scale
        let size = CGSize(width: scale*self.size.width, height: scale*self.size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        if style == .keepAlpha {
            context?.setBlendMode(.normal)
            context?.draw(self.cgImage!, in: rect)
            context?.setBlendMode(.sourceIn)
            color.setFill()
            context?.fill(rect)
        }else if style == .overAlpha {
            color.setFill()
            context?.fill(rect)
            context?.setBlendMode(.normal)
            context?.draw(self.cgImage!, in: rect)
        }else if style == .overAlphaExtreme {
            color.setFill()
            context?.fill(rect)
            context?.setBlendMode(CGBlendMode.destinationOut)
            context?.draw(self.cgImage!, in: rect)
        }

        let cgImage:CGImage? = context?.makeImage()
        UIGraphicsEndImageContext()
        if let cg = cgImage {
            return UIImage(cgImage: cg, scale: scale, orientation: UIImage.Orientation.up)
        }
        return nil
    }

}

// MARK: - init
public extension UIImage {

    convenience init(color:UIColor, size:CGSize=CGSize(width: 1.0, height: 1.0)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }

}


// MARK: - convert
/*
public extension UIImage {

    func toCGImage()->CGImage? {
        if let image = self.cgImage {
            return image
        }
        return self.toCIImage()?.cgImage
    }

    func toCIImage()->CIImage? {
        if let image = self.ciImage {
            return image
        }
        if let cg = self.toCGImage() {
            return CIImage(cgImage: cg)
        }
        return nil
    }

}
 */

public extension UIImage {

    var pixelSize:CGSize {
        let size = self.size
        return CGSize(width: size.width*self.scale, height: size.height*self.scale)
    }

    var pixelCount:UInt64 {
        let size = self.pixelSize
        return UInt64(size.width*size.height)
    }

}
