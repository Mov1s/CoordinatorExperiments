//
//  UINavigationController+Coordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

enum UINavigationControllerEvent: DispatchEvent {
    case coordinatorDidPush(UINavigationController)
}

extension UINavigationController {
    
    convenience init(rootCoordinator: Coordinator) {
        self.init(rootViewController: rootCoordinator.viewController)
        rootCoordinator.respond(to: UINavigationControllerEvent.coordinatorDidPush(self))
    }
    
    func pushViewCoordinator(coordinator: Coordinator, animated: Bool) {
        self.pushViewController(coordinator.viewController, animated: animated)
        coordinator.respond(to: UINavigationControllerEvent.coordinatorDidPush(self))
    }

    func setViewCoordinators(_ coordinators: [Coordinator], animated: Bool) {
        let views = coordinators.map { $0.viewController }
        self.setViewControllers(views, animated: animated)
        coordinators.forEach { $0.respond(to: UINavigationControllerEvent.coordinatorDidPush(self)) }
    }
}
