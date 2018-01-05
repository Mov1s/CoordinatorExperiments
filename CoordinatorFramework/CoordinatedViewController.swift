//
//  CoordinatedViewController.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import UIKit

public enum CoordinatedViewControllerEvent: DispatchEvent {
    case viewDidLoad
}

open class CoordinatedViewController: UIViewController, Coordinated {

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatch(event: CoordinatedViewControllerEvent.viewDidLoad)
    }
    
    
    //MARK: Coordinated Protocol
    
    
    open func respond(to event: DispatchEvent) {
    }
}
