//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import Foundation

class MainCoordinator: Coordinator {
    
    override init() {
        let vc = MainViewController()
        let vm = MainViewModel()
        let analytics = MainAnalytics()
        let router = MainRouter()
        let services = MainServices()
        super.init(withChildren: [ vm, vc, analytics, router, services ])
    }
}
