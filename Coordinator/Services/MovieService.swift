//
//  MovieService.swift
//  Coordinator
//
//  Created by Popa, Ryan on 12/1/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import Dispatch
import Foundation

class MovieService {
    
    private let movies = [ Movie(id: 345, title: "Generic Action Movie", genre: "Action / Adventure", synopsis: "Stuff happens, adventure ensues."),
                           Movie(id: 346, title: "Generic Crime Movie", genre: "Crime / Thriller", synopsis: "Someone dies, will they figure out who did it?") ]
    
    func fetchMovies(withCallback callback: @escaping ServiceCallback<[Movie]>) {
        Services.delay { callback(self.movies) }
    }
    
    func fetchMovie(withId id: Int, withCallback callback: @escaping ServiceCallback<Movie>) {
        let movie = self.movies.first { $0.id == id }
        Services.delay { callback(movie!) }
    }
}

extension Services {

    static var movies: MovieService { return MovieService() }
}
