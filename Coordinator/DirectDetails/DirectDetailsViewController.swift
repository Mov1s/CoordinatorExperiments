//
// Created by Popa, Ryan on 12/15/17.
// Copyright (c) 2017 Popa, Ryan. All rights reserved.
//

import CoordinatorFramework
import UIKit

enum DirectDetailsViewControllerEvent: DispatchEvent {
    case downloadButtonTapped
    case closeButtonTapped
}

class DirectDetailsViewController: UIViewController {

    var viewModel: DirectDetailsViewModel!

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

        self.populate(withViewModel: self.viewModel)
        self.viewModel.refresh()
    }


    //MARK: Actions


    @IBAction func onDownloadTapped(_ view: UIView?) {
        self.dispatch(event: DirectDetailsViewControllerEvent.downloadButtonTapped)
    }

    @IBAction func onCloseTapped(_ view: UIView?) {
        self.dispatch(event: DirectDetailsViewControllerEvent.closeButtonTapped)
    }


    //MARK: UI


    fileprivate func populate(withViewModel viewModel: DirectDetailsViewModel) {
        self.titleLabel.text = viewModel.movieTitleText
        self.genreLabel.text = viewModel.genreText
        self.synopsisTextView.text = viewModel.synopsisText
        //TODO: Poster URL
    }

    fileprivate func transition(toViewState state: DirectDetailsViewModelState) {
        UIView.animate(withDuration: 0.3) {
            self.loadingOverlay.alpha = state == .loading ? 1 : 0
        }
    }
}

extension DirectDetailsViewController: DirectDetailsRefreshListener {

    func viewModelDidRefresh(_ viewModel: DirectDetailsViewModel) {
        self.populate(withViewModel: viewModel)
    }

    func viewModel(_ viewModel: DirectDetailsViewModel, didTransitionToState state: DirectDetailsViewModelState) {
        self.transition(toViewState: state)
    }
}
