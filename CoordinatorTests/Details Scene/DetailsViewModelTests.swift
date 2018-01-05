//
//  DetailsViewModelTests.swift
//  CoordinatorTests
//
//  Created by Popa, Ryan on 12/21/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

@testable import Coordinator
@testable import CoordinatorFramework
import XCTest

class DetailsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_allProperties_whenInitialized() {
        let vm = DetailsViewModel()
        
        //Test
        XCTAssertEqual(vm.movieTitleText, "Unknown")
        XCTAssertEqual(vm.genreText, "Unknown")
        XCTAssertEqual(vm.synopsisText, "")
        XCTAssertNil(vm.posterUrl)
        XCTAssertEqual(vm.state, DetailsViewModelState.notStarted)
    }
    
    func test_beginLoad_whenViewDidLoad() {
        let expectation = self.expectation(description: "State Change Event Dispatched")
        let vm = DetailsViewModel()
        let _ = TestCoordinator(withChildren: [ vm ]) { event in
            guard case let DetailsViewModelEvent.viewModelDidChangeState(state) = event else { return }
            XCTAssertEqual(state, DetailsViewModelState.loading)
            expectation.fulfill()
        }
        
        //Test
        vm.respond(to: CoordinatedViewControllerEvent.viewDidLoad)
        XCTAssertEqual(vm.state, DetailsViewModelState.loading)
        self.wait(for: [ expectation ], timeout: 1)
    }
    
    func test_allProperties_whenMovieFetch() {
        let movie = Movie(id: 345, title: "Generic Action Movie", genre: "Action / Adventure", synopsis: "Stuff happens, adventure ensues.")
        let vm = DetailsViewModel()
        vm.respond(to: DetailsServicesEvent.didFetch(movie))
        
        //Test
        XCTAssertEqual(vm.movieTitleText, movie.title)
        XCTAssertEqual(vm.genreText, movie.genre)
        XCTAssertEqual(vm.synopsisText, movie.synopsis)
        XCTAssertEqual(vm.state, DetailsViewModelState.complete)
    }
    
    func test_updateEvent_whenViewDidLoad() {
        let expectation = self.expectation(description: "Update Event Dispatched")
        let vm = DetailsViewModel()
        let _ = TestCoordinator(withChildren: [ vm ]) { event in
            guard case DetailsViewModelEvent.viewModelDidUpdate(_) = event else { return }
            expectation.fulfill()
        }
        
        //Test
        vm.respond(to: CoordinatedViewControllerEvent.viewDidLoad)
        self.wait(for: [ expectation ], timeout: 1)
    }
    
    func test_updateEvent_whenMovieFetch() {
        let expectation = self.expectation(description: "Update Event Dispatched")
        let movie = Movie(id: 345, title: "Generic Action Movie", genre: "Action / Adventure", synopsis: "Stuff happens, adventure ensues.")
        let vm = DetailsViewModel()
        let _ = TestCoordinator(withChildren: [ vm ]) { event in
            guard case DetailsViewModelEvent.viewModelDidUpdate(_) = event else { return }
            expectation.fulfill()
        }
        
        //Test
        vm.respond(to: DetailsServicesEvent.didFetch(movie))
        self.wait(for: [ expectation ], timeout: 1)
    }
}
