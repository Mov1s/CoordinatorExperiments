//
//  DetailsServices.swift
//  Coordinator
//
//  Created by Popa, Ryan on 12/1/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum DetailsServicesEvent: DispatchEvent {
    case didFetch(Movie)
}

final class DetailsServices: UIResponder, Coordinated {
    
    typealias MovieFetcher = (@escaping (Movie) -> Void) -> Void
    
    private let fetcher: MovieFetcher
    
    init(withWithFetcher fetcher: @escaping MovieFetcher) {
        self.fetcher = fetcher
    }
    
    convenience init(withMovieId id: Int) {
        self.init() { Services.movies.fetchMovie(withId: id, withCallback: $0) }
    }
    
    func respond(to event: DispatchEvent) {
        switch event {
            
        //View model has started loading, request movie details
        case DetailsViewModelEvent.viewModelDidChangeState(let state) where state == .loading:
            self.fetcher() { self.dispatch(event: DetailsServicesEvent.didFetch($0)) }
            
        default: return
        }
    }
}
