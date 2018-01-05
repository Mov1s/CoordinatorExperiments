//
//  BasicCoordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

protocol Coordinated {
    func respond(to event: DispatchEvent)
}

protocol GlobalDispatchEventCoordinator {

}

class Coordinator: Coordinated {
    
    var viewController: UIViewController = UIViewController()
    var coordinatedChildren = [Coordinated]()
    
    init() {
        if self is GlobalDispatchEventCoordinator {
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "GlobalDispatchEventNotification"),
                    object: nil, queue: nil,
                    using: self.respondToGlobalDispatchEvent)
        }
    }
    
    init(withChildren children: [Any]) {
        if self is GlobalDispatchEventCoordinator {
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "GlobalDispatchEventNotification"),
                    object: nil, queue: nil,
                    using: self.respondToGlobalDispatchEvent)
        }
        self.register(children: children)
    }

    func respond(to event: DispatchEvent) {
        coordinatedChildren.forEach { $0.respond(to: event) }
    }

    func register(child: Any) {
        if let responder = child as? UIResponder { responder.coordinator = self }
        if let coordinated = child as? Coordinated { self.coordinatedChildren.append(coordinated) }
        if let viewController = child as? UIViewController { self.viewController = viewController }
    }
    
    func register(children: [Any]) {
        children.forEach { self.register(child: $0) }
    }

    fileprivate func respondToGlobalDispatchEvent(_ notification: Notification) {
        let object = notification.object as AnyObject
        if let event = object as? DispatchEvent {
            self.respond(to: event)
        }
    }
}
