//
//  PayCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

class PayCoordinator: NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showListCreditCardViewController()
    }
    
    fileprivate func showListCreditCardViewController() {
        
//        guard let contest = contest else {
//            return
//        }
        let viewModel = ListCreditCardViewModel()
        viewModel.delegate = self
        let listCreditCardViewController = ListCreditCardViewController(viewModel: viewModel)
//        listCreditCardViewController.delegate = self
        self.navigationController.pushViewController(listCreditCardViewController, animated: true)
    }
}

extension PayCoordinator: ListCreditCardViewModelDelegate {
    
    func listCreditCardDidAddCardClick(_ listCreditCardViewModel: ListCreditCardViewModel) {
        
        let addPaymentCoordinator = AddPaymentCoordinator(navigationController: navigationController)
        addPaymentCoordinator.delegate = self
        addPaymentCoordinator.start()
        self.addChildCoordinator(addPaymentCoordinator)
//        let viewModel = AddPaymentViewModel()
//        viewModel.delegate = self
//        let addPaymentViewController = AddPaymentMethodViewController(viewModel: viewModel)
//        let addPaymentMethodNavigationController = UINavigationController(rootViewController: addPaymentViewController)
//
//        self.navigationController.present(addPaymentMethodNavigationController, animated: true, completion: nil)
    }
    
    func listCreditCardDidClickToPay(_ listCreditCardViewModel: ListCreditCardViewModel) {
        self.navigationController.popViewController(animated: true)
    }
    
//    func createContestCoordinatorDelegateDidCancel(_ createContestCoordinator: CreateContestCoordinator) {
//        createContestCoordinator.navigationController.popToRootViewController(animated: true)
//        self.removeChildCoordinator(createContestCoordinator)
//    }
//
//    func createContestCoordinator(_ createContestCoordinator: CreateContestCoordinator, didCreateContest contest: Contest) {
//        createContestCoordinator.navigationController.popToRootViewController(animated: true)
//        self.removeChildCoordinator(createContestCoordinator)
//    }
}

extension PayCoordinator: AddPaymentCoordinatorDelegate {
    func addPaymentCoordinatorDelegateDidCancel(_ addPaymentCoordinator: AddPaymentCoordinator) {        
        addPaymentCoordinator.navigationController.dismiss(animated: true, completion: nil)
        self.removeChildCoordinator(addPaymentCoordinator)
    }
    
    func addPaymentCoordinator(_ addPaymentCoordinator: AddPaymentCoordinator, didCreateCard card: Card) {
        addPaymentCoordinator.navigationController.dismiss(animated: true, completion: nil)
        self.removeChildCoordinator(addPaymentCoordinator)
    }
}
