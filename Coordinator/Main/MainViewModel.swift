//
//  MainViewModel.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum MainViewModelEvent: DispatchEvent {
    case modelDidUpdate(MainViewModel)
}

class MainViewModel: UIResponder, Coordinated {
    
    var titleTest: String = "Unknown"
    
    override init() {
        super.init()
    }
    
    func respond(to event: DispatchEvent) {
        
        switch event {
        case MainViewControllerEvent.viewDidLoad, MainViewControllerEvent.buttonTapped:
            refresh()
        default:
            return
        }
    }
    
    func refresh() {
        let num = String(arc4random())
        titleTest = num
        self.dispatch(event: MainViewModelEvent.modelDidUpdate(self))
    }
}
