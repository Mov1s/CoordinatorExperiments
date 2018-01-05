//
//  MainAnalytics.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import Foundation

class MainAnalytics: Coordinated {
    
    func respond(to event: DispatchEvent) {
        switch event {
        case MainViewControllerEvent.buttonTapped:
            print("Button Tapped")
        case MainViewControllerEvent.nextButtonTapped:
            print("Pushed to Details")
        case MainViewControllerEvent.modalButtonTapped:
            print("Modally presented Details")
            
        default:
            return
        }
    }
}
