//
//  DetailsRouter.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

class DetailsRouter: Coordinated {
    
    var navigationController: UINavigationController?
    
    func respond(to event: DispatchEvent) {
        switch event {
        case UINavigationControllerEvent.coordinatorDidPush(let nav):
            self.navigationController = nav
            
        case DetailsViewControllerEvent.closeButtonTapped:
            self.navigationController?.popViewController(animated: true)
            
        default:
            return
        }
    }
}

class DetailsModalRouter: Coordinated {
    
    var navigationController: UINavigationController?
    
    func respond(to event: DispatchEvent) {
        switch event {
        case UINavigationControllerEvent.coordinatorDidPush(let nav):
            self.navigationController = nav
            
        case DetailsViewControllerEvent.closeButtonTapped:
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        default:
            return
        }
    }
}
