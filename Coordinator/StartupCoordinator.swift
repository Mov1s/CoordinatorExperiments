//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

class StartupCoordinator: Coordinator, GlobalDispatchEventCoordinator {

    fileprivate var rootNavController: UINavigationController? {
        return self.viewController as? UINavigationController
    }

    override init() {
        super.init()

        //When not logged in show login screen
        if !SessionService.isLoggedIn {
            let loginCoordinator = LoginCoordinator()
            let viewController = UINavigationController(rootCoordinator: loginCoordinator)
            self.register(children: [ loginCoordinator, viewController ])
        }

        //When logged in go to main
        else {
            let mainCoordinator = MainCoordinator()
            let viewController = UINavigationController(rootCoordinator: mainCoordinator)
            self.register(children: [ mainCoordinator, viewController ])
        }
    }

    override func respond(to event: DispatchEvent) {
        super.respond(to: event)
        switch event {

        //Global log out event
        //Reset the nav stack to show login screen
        case GlobalDispatchEvent.logOut:
            let loginCoordinator = LoginCoordinator()
            self.removeRegisteredChildren()
            self.register(children: [loginCoordinator, self.viewController])
            self.rootNavController?.setViewCoordinators([loginCoordinator], animated:true)

        default: return
        }
    }
}
