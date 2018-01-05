//
//  UIViewController+Coordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

public enum UIViewControllerEvent: DispatchEvent {
    case coordinatorDidPresent(UIViewController)
}

extension UIViewController {
    
    public func present(viewControllerToPresent: UIViewController, coordinateWith coordinator: Coordinator, animated: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: animated, completion: completion)
        coordinator.respond(to: UIViewControllerEvent.coordinatorDidPresent(self))
    }
    
    public func present(coordinatorToPresent: Coordinator, animated: Bool, completion: (() -> Void)?) {
        guard let viewController = coordinatorToPresent.viewController else { return }
        self.present(viewControllerToPresent: viewController, coordinateWith: coordinatorToPresent, animated: animated, completion: completion)
    }
}
