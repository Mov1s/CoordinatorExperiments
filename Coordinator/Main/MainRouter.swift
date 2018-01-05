//
//  MainRouter.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

class MainRouter: UIResponder, Coordinated {
    
    var navigationController: UINavigationController?
    
    func respond(to event: DispatchEvent) {
        switch event {
        case UINavigationControllerEvent.coordinatorDidPush(let nav):
            self.navigationController = nav
            
        case MainViewControllerEvent.nextButtonTapped:
            let detailsCoord = DetailsCoordinator(withMovieId: 345)
            self.navigationController?.pushViewCoordinator(coordinator: detailsCoord, animated: true)

//        case MainViewControllerEvent.modalButtonTapped:
//            let detailsCoord = DetailsModalCoordinator(withMovieId: 346)
//            let nav = UINavigationController(rootCoordinator: detailsCoord)
//            self.navigationController?.present(viewControllerToPresent: nav, coordinateWith: detailsCoord, animated: true, completion: nil)

        case MainViewControllerEvent.modalButtonTapped:
            let directDetailsCoord = DirectDetailsCoordinator(withMovieId: 345)
            let nav = UINavigationController(rootCoordinator: directDetailsCoord)
            self.navigationController?.present(viewControllerToPresent: nav, coordinateWith: directDetailsCoord, animated: true, completion: nil)

        default:
            return
        }
    }
}
