//
//  AddPaymentCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 29/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol AddPaymentCoordinatorDelegate: class {
    func addPaymentCoordinatorDelegateDidCancel(_ addPaymentCoordinator: AddPaymentCoordinator)
    func addPaymentCoordinator(_ addPaymentCoordinator: AddPaymentCoordinator, didCreateCard card: Card)
}

class AddPaymentCoordinator: NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: AddPaymentCoordinatorDelegate?
    var addPaymentViewModel: AddPaymentViewModel
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        addPaymentViewModel = AddPaymentViewModel()
    }
    
    func start() {
        showAddPaymentViewController()
    }
    
    private func showAddPaymentViewController() {
//        let viewModel = AddPaymentViewModel()
        addPaymentViewModel.delegate = self
        let addPaymentViewController = AddPaymentMethodViewController(viewModel: addPaymentViewModel)
        let addPaymentNavigationController = UINavigationController(rootViewController: addPaymentViewController)
        
        self.navigationController.present(addPaymentNavigationController, animated: true, completion: nil)
//        let createContestSelectMediaViewController = CreateContestSelectMediaViewController(viewModel: createContestViewModel)
//        createContestViewModel.delegate = self
//        self.navigationController.pushViewController(createContestSelectMediaViewController, animated: true)
    }
}

extension AddPaymentCoordinator: AddPaymentViewModelDelegate {
    
    func addPaymentViewDidClickCancel(_ addPaymentViewModel: AddPaymentViewModel) {
        self.delegate?.addPaymentCoordinatorDelegateDidCancel(self)
    }
    
    func addPaymentView(_ addPaymentViewModel: AddPaymentViewModel, didCreateCard card: Card) {
        self.delegate?.addPaymentCoordinator(self, didCreateCard: card)
    }
    
//    func createContestViewDidClickCancel(_ createContestViewModel: AddPaymentViewModel) {
//        self.delegate?.createContestCoordinatorDelegateDidCancel(self)
//    }
//
//    func createContestView(_ createContestViewModel: CreateContestViewModel, didSelectMedia media: Media) {
//        showCreateContestViewController(media)
//    }
//
//    func createContestView(_ createContestViewModel: CreateContestViewModel, didCreateContest contest: Contest) {
//        self.delegate?.createContestCoordinator(self, didCreateContest: contest)
//    }
//
//    func createContestView(_ createContestViewModel: CreateContestViewModel, didClickViewOnIG media: Media) {
//        self.openMedia(media)
//    }
}
