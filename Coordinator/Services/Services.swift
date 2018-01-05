//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import Foundation

typealias ServiceCallback<T> = (T) -> Void

class Services {

    static func delay(closure: @escaping ()->()) {
        let delay = Double(arc4random_uniform(4)) //Up to 3 sec
        let delayTime = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: closure)
    }
}
