//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import Foundation

class SessionService {

    static var isLoggedIn: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "LoggedIn")
            UserDefaults.standard.synchronize()
        }

        get { return UserDefaults.standard.bool(forKey: "LoggedIn") }
    }
}