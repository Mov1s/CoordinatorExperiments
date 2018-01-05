//
// Created by Popa, Ryan on 12/21/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

final class MainServices: UIResponder, Coordinated {

    func respond(to event: DispatchEvent) {
        switch event {
        case MainViewControllerEvent.logOutButtonTapped:
            Services.authentication.clear()
            dispatch(globalEvent: GlobalDispatchEvent.logOut)
        default: return
        }
    }
}
