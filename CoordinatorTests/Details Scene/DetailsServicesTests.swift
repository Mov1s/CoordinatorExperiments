//
//  DetailsServicesTests.swift
//  CoordinatorTests
//
//  Created by Popa, Ryan on 12/22/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

@testable import Coordinator
import XCTest

class DetailsServicesTests: XCTestCase {
    
    func test_fetchMovie_whenViewModelStateChanges() {
        let expectation = self.expectation(description: "Movie Fetch Event Dispatched")
        let movie = Movie(id: 345, title: "Generic Action Movie", genre: "Action / Adventure", synopsis: "Stuff happens, adventure ensues.")
        let services = DetailsServices() { $0(movie) }
        let _ = TestCoordinator(withChildren: [ services ]) { event in
            guard case let DetailsServicesEvent.didFetch(m) = event else { return }
            XCTAssertEqual(movie.id, m.id)
            expectation.fulfill()
        }
        
        //Test
        services.respond(to: DetailsViewModelEvent.viewModelDidChangeState(.loading))
        self.wait(for: [ expectation ], timeout: 1)
    }
}
