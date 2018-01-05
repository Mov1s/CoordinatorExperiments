//
//  DetailsCoordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import Foundation

class DetailsCoordinator: Coordinator {
    
    init(withMovieId id: Int) {
        super.init(withChildren: [ DetailsViewModel(), DetailsRouter(), DetailsServices(withMovieId: id), DetailsViewController() ])
    }
}

class DetailsModalCoordinator: Coordinator {
    
    init(withMovieId id: Int) {
        super.init(withChildren: [ DetailsViewController(), DetailsViewModel(), DetailsModalRouter(), DetailsServices(withMovieId: id) ])
    }
}
