//
//  CoordinatorFrameworkTests.swift
//  CoordinatorFrameworkTests
//
//  Created by Popa, Ryan on 12/21/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import XCTest
@testable import CoordinatorFramework

class CoordinatorFrameworkTests: XCTestCase {
    
    func test_viewController_whenRegistered() {
        let viewController = UIViewController()
        let coord = Coordinator(withChildren: [ viewController ])
        
        //Test
        XCTAssertEqual(coord.viewController, viewController)
    }
    
    func test_coordinatorOfChildren_whenRegistered() {
        let responder = UIResponder()
        let coord = Coordinator(withChildren: [ responder ])
        
        //Test
        XCTAssert(responder.coordinator === coord)
    }
    
    func test_coordinatedChildren_whenRegistered() {
        let child = TestCoordinated()
        let coord = Coordinator(withChildren: [ child ])
        
        //Test
        XCTAssertEqual(coord.coordinatedChildren.count, 1)
        XCTAssert(coord.coordinatedChildren.first === child)
    }
    
    func test_globalEvents_whenInitializedWithNoChildren() {
        let responder = UIResponder()
        let coord = TestGlobalCoordinator()
        
        //Test
        responder.dispatch(globalEvent: TestDispathEvent.test)
        //TODO: Verify event is seen
    }
    
    func test_globalEvents_whenInitializedWithChildren() {
        let responder = UIResponder()
        let child = TestCoordinated()
        let coord = TestGlobalCoordinator(withChildren: [ child ])
        
        //Test
        responder.dispatch(globalEvent: TestDispathEvent.test)
        //TODO: Verify event is seen
    }
    
    func test_globalEvents_whenCoordinatorIsNotGlobal() {
        let responder = UIResponder()
        let nonGlobalCoord = Coordinator(withChildren: [ responder ])
        
        //Test
        responder.dispatch(globalEvent: TestDispathEvent.test)
        //TODO: Verify event is seen in nonGlobalCoord
    }
}

fileprivate class TestCoordinated: Coordinated {
    func respond(to event: DispatchEvent) {}
}

fileprivate class TestGlobalCoordinator: Coordinator, GlobalDispatchEventCoordinator {
    
}

fileprivate enum TestDispathEvent: DispatchEvent {
    case test
}
