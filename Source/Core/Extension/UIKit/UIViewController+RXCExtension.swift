//
//  UIViewController+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 3/9/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import UIKit

public extension UIViewController {

    @discardableResult
    func dismissOrPop(animated:Bool, completion:(()->Void)?) -> Bool{
        if let nav = self.navigationController {
            //we are embeded in a Nav
            if nav.viewControllers.first === self && nav.topViewController === self {
                //and we are the only one in the Nav
                if nav.presentingViewController != nil {
                    //the nav is presented, just dismiss
                    nav.dismiss(animated: animated, completion: completion)
                    return true
                }else{
                    //the nav is not been presented, WTF
                    print("a VC as ROOT of a Nav want to dismissOrPop while the NAV is not been presented")
                    return false
                }
            }else if nav.topViewController === self && nav.viewControllers.first !== self {
                //we are at the top, just pop is fine
                nav.popViewController(animated: animated)
                return true
            }else {
                //WTF, we are in the middle range of a Nav
                print("WARNING:  A VC in the middle range of a Nav stack is trying to dismissOrPop, we just pop once")
                nav.popViewController(animated: animated)
                return true
            }
        }else if self.presentingViewController != nil {
                //we are presented
                self.dismiss(animated: animated, completion: completion)
                return true
        }else if let vc = self.closestViewController() {
            //WTF? we are not presented or embeded in a Nav, WTFFF ?
            return vc.dismissOrPop(animated: animated, completion: completion)
        }else {
            return false
        }
    }

}
