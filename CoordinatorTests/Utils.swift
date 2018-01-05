//
//  Utils.swift
//  CoordinatorTests
//
//  Created by Popa, Ryan on 12/22/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

@testable import CoordinatorFramework
import Foundation

class TestCoordinator: Coordinator {
    
    fileprivate var block: ((DispatchEvent) -> Void)?
    
    init(withChildren children: [Any], responderBlock: ((DispatchEvent) -> Void)? = nil) {
        super.init(withChildren: children)
        self.block = responderBlock
    }
    
    override func respond(to event: DispatchEvent) {
        super.respond(to: event)
        self.block?(event)
    }
}
