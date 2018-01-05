//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import Foundation

class AuthenticationService {

    func authenticate(withToken token: String, withCallback callback: @escaping ServiceCallback<User>) {
        let user = User(name: "Ryan")
        SessionService.isLoggedIn = true
        Services.delay { callback(user) }
    }

    func clear() {
        SessionService.isLoggedIn = false
    }
}

extension Services {

    static var authentication: AuthenticationService { return AuthenticationService() }
}