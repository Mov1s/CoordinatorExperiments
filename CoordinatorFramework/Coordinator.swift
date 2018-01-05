//
//  Coordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

public protocol DispatchEvent {
}

public protocol Coordinated: AnyObject {
    func respond(to event: DispatchEvent)
}

public protocol GlobalDispatchEventCoordinator {

}

open class Coordinator: Coordinated {
    
    public var viewController: UIViewController?
    public var coordinatedChildren = [Coordinated]()
    
    public init() {
        if self is GlobalDispatchEventCoordinator {
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "GlobalDispatchEventNotification"),
                    object: nil, queue: nil,
                    using: self.respondToGlobalDispatchEvent)
        }
    }
    
    public init(withChildren children: [Any?]) {
        if self is GlobalDispatchEventCoordinator {
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "GlobalDispatchEventNotification"),
                    object: nil, queue: nil,
                    using: self.respondToGlobalDispatchEvent)
        }
        self.register(children: children)
    }

    open func respond(to event: DispatchEvent) {
        coordinatedChildren.forEach { $0.respond(to: event) }
    }

    public func register(child: Any?, strong: Bool = false) {
        if let responder = child as? UIResponder { responder.coordinator = self }
        if let coordinated = child as? Coordinated { self.coordinatedChildren.append(coordinated) }
        if let viewController = child as? UIViewController { self.viewController = viewController }
    }
    
    public func register(children: [Any?]) {
        children.forEach { self.register(child: $0) }
    }

    public func removeRegisteredChildren() {
        self.coordinatedChildren = []
    }
    
    fileprivate func respondToGlobalDispatchEvent(_ notification: Notification) {
        let object = notification.object as AnyObject
        if let event = object as? DispatchEvent {
            self.respond(to: event)
        }
    }
}
