//
//  DetailsViewController.swift
//  Coordinator
//
//  Created by Popa, Ryan on 11/30/17.
//  Copyright © 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum DetailsViewControllerEvent: DispatchEvent {
    case downloadButtonTapped
    case closeButtonTapped
}

class DetailsViewController: CoordinatedViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var loadingOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If modal add close button
        if self.presentingViewController != nil && self.navigationController != nil && self.navigationController!.viewControllers.first! == self {
            let modalCloseButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(onCloseTapped(_:)))
            self.navigationItem.leftBarButtonItem = modalCloseButton
        }
    }
    
    
    //MARK: Coordinated Protocol
    
    
    override func respond(to event: DispatchEvent) {
        super.respond(to: event)
        switch event {
            
        //View model updated, refresh view
        case DetailsViewModelEvent.viewModelDidUpdate(let vm):
            self.populate(withViewModel: vm)
            
        //View model changed state, refresh view
        case DetailsViewModelEvent.viewModelDidChangeState(let state):
            self.transition(toViewState: state)
            
        default: return
        }
    }
    
    
    //MARK: Actions
    
    
    @IBAction func onDownloadTapped(_ view: UIView?) {
        self.dispatch(event: DetailsViewControllerEvent.downloadButtonTapped)
    }
    
    @IBAction func onCloseTapped(_ view: UIView?) {
        self.dispatch(event: DetailsViewControllerEvent.closeButtonTapped)
    }
    
    
    //MARK: UI
    
    
    private func populate(withViewModel viewModel: DetailsViewModel) {
        self.titleLabel.text = viewModel.movieTitleText
        self.genreLabel.text = viewModel.genreText
        self.synopsisTextView.text = viewModel.synopsisText
        //TODO: Poster URL
    }
    
    private func transition(toViewState state: DetailsViewModelState) {
        UIView.animate(withDuration: 0.3) {
            self.loadingOverlay.alpha = state == .loading ? 1 : 0
        }
    }
}
