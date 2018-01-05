//
// Created by Popa, Ryan on 12/20/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import Dispatch
import UIKit

enum LoginViewControllEvent: DispatchEvent {
    case finishedWelcomeAnimations
    case tappedAuthenticatedButton
}

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginFormView: UIView!
    @IBOutlet weak var loginFormCenterConstraint: NSLayoutConstraint!
    
    var viewModel: LoginViewModel?

    func viewModelDidRefresh(_ viewModel: LoginViewModel) {

    }

    func viewModelDidChangeState(_ viewModel: LoginViewModel, to state: LoginViewModel.ViewState) {
        switch state {
        case .authenticating:
            showLoading()
            hideLoginForm()
        case .authenticated(let userName):
            self.nameLabel.text = "Welcome \(userName)!"
            self.showNameLabel()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.dispatch(event: LoginViewControllEvent.finishedWelcomeAnimations)
            }
            fallthrough
        default: hideLoading()
        }
    }

    //MARK: Actions
    
    @IBAction func onLoginTapped(_ sender: Any?) {
        self.dispatch(event: LoginViewControllEvent.tappedAuthenticatedButton)
    }
    
    //MARK: UI

    fileprivate func animateLoadingAlpha(to alpha: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.alpha = alpha
        }
    }

    fileprivate func showLoading() { self.animateLoadingAlpha(to: 1) }

    fileprivate func hideLoading() { self.animateLoadingAlpha(to: 0) }

    fileprivate func animateNameLabelAlpha(to alpha: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.nameLabel.alpha = alpha
        }
    }

    fileprivate func showNameLabel() { self.animateNameLabelAlpha(to: 1) }
    
    fileprivate func hideLoginForm() {
        self.loginFormCenterConstraint.constant = 40
        UIView.animate(withDuration: 0.3) {
            var rotationAndPerspectiveTransform = CATransform3DIdentity;
            rotationAndPerspectiveTransform.m34 = 1.0 / -200;
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, CGFloat(45.0 * Double.pi / 180.0), 1.0, 0.0, 0.0)
//            CGAffineTransformConcat(rotationAndPerspectiveTransform, scale)
//            self.loginFormView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.loginFormView.layer.transform = rotationAndPerspectiveTransform
            self.loginFormView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}
