//
// Created by Popa, Ryan on 12/15/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import Foundation

protocol DirectDetailsRefreshListener {
    func viewModelDidRefresh(_ viewModel: DirectDetailsViewModel)
    func viewModel(_ viewModel: DirectDetailsViewModel, didTransitionToState state: DirectDetailsViewModelState)
}

enum DirectDetailsViewModelState {
    case notStarted
    case loading
    case complete
    case error
}

class DirectDetailsViewModel {

    typealias MovieFetcher = (@escaping (Movie) -> Void) -> Void

    let fetcher: MovieFetcher
    let listener: DirectDetailsRefreshListener?

    private(set) var movieTitleText: String = "Unknown"
    private(set) var genreText: String = "Unknown"
    private(set) var synopsisText: String = ""
    private(set) var posterUrl: String?
    private(set) var state: DirectDetailsViewModelState = .notStarted {
       didSet { self.listener?.viewModel(self, didTransitionToState: self.state) }
    }

    init(withFetcher fetcher: @escaping MovieFetcher, andListener listener: DirectDetailsRefreshListener?) {
        self.fetcher = fetcher
        self.listener = listener
    }

    func refresh() {
        self.state = .loading
        self.fetcher() { movie in
            self.movieTitleText = movie.title
            self.genreText = movie.genre
            self.synopsisText = movie.synopsis
            self.state = .complete
            self.listener?.viewModelDidRefresh(self)
        }
    }
}