//
//  CoordinatedViewController.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

enum CoordinatedViewControllerEvent: DispatchEvent {
    case viewDidLoad
}

class CoordinatedViewController: UIViewController, Coordinated {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatch(event: CoordinatedViewControllerEvent.viewDidLoad)
    }
    
    
    //MARK: Coordinated Protocol
    
    
    func respond(to event: DispatchEvent) {
    }
}
