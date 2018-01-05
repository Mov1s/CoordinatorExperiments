//
// Created by Popa, Ryan on 12/15/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import Foundation

class DirectDetailsCoordinator: Coordinator {

    init(withMovieId id: Int) {

        //Create VC
        let vc = DirectDetailsViewController()

        //Create and configure VM
        let fetcher = { Services.movies.fetchMovie(withId: id, withCallback: $0) }
        let vm = DirectDetailsViewModel(withFetcher: fetcher, andListener: vc)
        vc.viewModel = vm

        //Set the VC
        super.init(withChildren: [ vm, vc ])
    }

    override func respond(to event: DispatchEvent) {
        super.respond(to: event)

        switch event {
        case DirectDetailsViewControllerEvent.closeButtonTapped:
            self.viewController?.dismiss(animated: true, completion: nil)
        default: return
        }
    }
}
