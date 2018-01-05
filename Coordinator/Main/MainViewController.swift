//
//  MainViewController.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum MainViewControllerEvent: DispatchEvent {
    case viewDidLoad
    case buttonTapped
    case nextButtonTapped
    case modalButtonTapped
    case logOutButtonTapped
}

class MainViewController: UIViewController, Coordinated {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatch(event: MainViewControllerEvent.viewDidLoad)
    }
    
    func respond(to event: DispatchEvent) {
        switch event {
        case MainViewModelEvent.modelDidUpdate(let model):
            self.label.text = model.titleTest
        default:
            return
        }
    }
    
    @IBAction func onButtonTapped(_ view: UIView?) {
        dispatch(event: MainViewControllerEvent.buttonTapped)
    }
    
    @IBAction func onNextButtonTapped(_ view: UIView?) {
        dispatch(event: MainViewControllerEvent.nextButtonTapped)
    }
    
    @IBAction func onModalButtonTapped(_ view: UIView?) {
        dispatch(event: MainViewControllerEvent.modalButtonTapped)
    }
    
    @IBAction func onLogOutButtonTapped(_view: UIView?) {
        dispatch(globalEvent: MainViewControllerEvent.logOutButtonTapped)
    }
}
