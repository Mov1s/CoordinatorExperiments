//
//  UINavigationController+Coordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

public enum UINavigationControllerEvent: DispatchEvent {
    case coordinatorDidPush(UINavigationController)
}

extension UINavigationController {
    
    public convenience init(rootCoordinator: Coordinator) {
        guard let viewController = rootCoordinator.viewController else {
            self.init()
            return
        }
        self.init(rootViewController: viewController)
        rootCoordinator.respond(to: UINavigationControllerEvent.coordinatorDidPush(self))
    }
    
    public func pushViewCoordinator(coordinator: Coordinator, animated: Bool) {
        guard let viewController = coordinator.viewController else { return }
        self.pushViewController(viewController, animated: animated)
        coordinator.respond(to: UINavigationControllerEvent.coordinatorDidPush(self))
    }

    public func setViewCoordinators(_ coordinators: [Coordinator], animated: Bool) {
        let views = coordinators.flatMap { $0.viewController }
        self.setViewControllers(views, animated: animated)
        coordinators.forEach { $0.respond(to: UINavigationControllerEvent.coordinatorDidPush(self)) }
    }
}
