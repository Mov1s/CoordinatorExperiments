//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum LoginViewModelEvent: DispatchEvent {
    case authenticated
}

protocol LoginView {
    var viewModel: LoginViewModel? { get set }

    func viewModelDidRefresh(_ viewModel: LoginViewModel)
    func viewModelDidChangeState(_ viewModel: LoginViewModel, to state: LoginViewModel.ViewState)
}

class LoginViewModel: UIResponder {

    typealias UserAuthenticator = (@escaping (User) -> Void) -> Void

    enum ViewState {
        case unauth
        case authenticating
        case authenticated(String)
        case error(String)
    }

    fileprivate (set) var viewState: ViewState = .unauth {
        didSet { self.view?.viewModelDidChangeState(self, to: self.viewState) }
    }

    fileprivate var view: LoginView?
    var authenticator: UserAuthenticator?

    init(withAuthenticator authenticator: UserAuthenticator?, andView view: LoginView? = nil) {
        super.init()
        self.authenticator = authenticator
        self.view = view
        self.view?.viewModel = self
    }

    func refresh() {
        //Do nothing
    }

    func authenticate() {
        self.viewState = .authenticating
        self.authenticator?() { user in
            self.viewState = .authenticated(user.name)
            self.dispatch(event: LoginViewModelEvent.authenticated)
        }
    }
}
