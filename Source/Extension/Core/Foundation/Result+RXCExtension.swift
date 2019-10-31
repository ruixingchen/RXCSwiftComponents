//
//  Result+RXCExtension.swift
//  CoolMarket
//
//  Created by ruixingchen on 4/10/19.
//  Copyright © 2019 CoolApk. All rights reserved.
//

import Foundation

public extension Swift.Result {

    var value:Success? {
        return try? self.get()
    }

    var error:Failure? {
        do {
            let _ = try self.get()
        }catch {
            return (error as! Failure)
        }
        return nil
    }

}
