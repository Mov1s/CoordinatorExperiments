//
//  UIResponder+Dispatch.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

protocol DispatchEvent {
}

private var assoc_coordinator: UInt8 = 0

extension UIResponder {
    
    var coordinator: Coordinator? {
        set {
            objc_setAssociatedObject(self, &assoc_coordinator, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &assoc_coordinator) as? Coordinator
        }
    }
    
    func dispatch(event: DispatchEvent) {
        if let coordinator = self.coordinator {
            coordinator.respond(to: event)
        } else {
            self.next?.dispatch(event: event)
        }
    }

    func dispatch(globalEvent: DispatchEvent) {
        self.dispatch(event: globalEvent)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "GlobalDispatchEventNotification"), object: globalEvent)
    }
}
