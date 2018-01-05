//
//  DetailsViewModel.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum DetailsViewModelEvent: DispatchEvent {
    case viewModelDidUpdate(DetailsViewModel)
    case viewModelDidChangeState(DetailsViewModelState)
}

enum DetailsViewModelState {
    case notStarted
    case loading
    case complete
    case error
}

class DetailsViewModel: UIResponder, Coordinated {
    
    private(set) var movieTitleText: String = "Unknown"
    private(set) var genreText: String = "Unknown"
    private(set) var synopsisText: String = ""
    private(set) var posterUrl: String?
    private(set) var state: DetailsViewModelState = .notStarted {
        didSet { self.dispatch(event: DetailsViewModelEvent.viewModelDidChangeState(self.state)) }
    }
    
    func respond(to event: DispatchEvent) {
        switch event {
            
        //View controller has loaded, trigger initial state of the view model
        case CoordinatedViewControllerEvent.viewDidLoad:
            self.dispatch(event: DetailsViewModelEvent.viewModelDidUpdate(self))
            
            //Start loading
            self.state = .loading
            
        //Service has loaded movie, update view model and alert of new state
        case DetailsServicesEvent.didFetch(let movie):
            self.movieTitleText = movie.title
            self.genreText = movie.genre
            self.synopsisText = movie.synopsis
            self.state = .complete
            self.dispatch(event: DetailsViewModelEvent.viewModelDidUpdate(self))
            
        default: return
        }
    }
}
