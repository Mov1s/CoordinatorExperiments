//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

class LoginCoordinator: Coordinator {

    fileprivate let viewModel: LoginViewModel
    fileprivate var navigationController: UINavigationController?

    override init() {
        let viewController = LoginViewController()
        self.viewModel = LoginViewModel(withAuthenticator: nil, andView: viewController)
        super.init(withChildren: [ viewController, self.viewModel ])
    }

    override func respond(to event: DispatchEvent) {
        super.respond(to: event)

        //Authentication deeplink
        if let event = event as? URL, event.path == "/login/authenticate",
           let token = event.queryParams["token"] {

            //Authenticate against the deeplink token
            let authenticator = { Services.authentication.authenticate(withToken: token, withCallback: $0) }
            self.viewModel.authenticator = authenticator
            self.viewModel.authenticate()
        }

        switch event {
        case UINavigationControllerEvent.coordinatorDidPush(let nav):
            self.navigationController = nav
        case LoginViewControllEvent.finishedWelcomeAnimations:
            let mainCoordinator = MainCoordinator()
            self.navigationController?.setViewCoordinators([ mainCoordinator ], animated: true)
        case LoginViewControllEvent.tappedAuthenticatedButton:
            let authenticator = { Services.authentication.authenticate(withToken: "", withCallback: $0) }
            self.viewModel.authenticator = authenticator
            self.viewModel.authenticate()
        default: return
        }
    }
}
