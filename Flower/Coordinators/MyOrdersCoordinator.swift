//
//  MyOrdersCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 30/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MyOrdersCoordinatorDelegate: class {
//    func addPaymentCoordinatorDelegateDidCancel(_ addPaymentCoordinator: AddPaymentCoordinator)
//    func addPaymentCoordinator(_ addPaymentCoordinator: AddPaymentCoordinator, didCreateCard card: Card)
}

class MyOrdersCoordinator: NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: MyOrdersCoordinatorDelegate?
    var myOrdersViewModel: MyOrdersViewModel
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        myOrdersViewModel = MyOrdersViewModel()
    }
    
    func start() {
        self.navigationController.setViewControllers([initMyOrdersViewController()], animated: false)
    }
    
    private func initMyOrdersViewController() -> MyOrdersViewController {
        //        let viewModel = AddPaymentViewModel()
        myOrdersViewModel.delegate = self
        let myOrdersViewController = MyOrdersViewController(viewModel: myOrdersViewModel)
//        let myOrdersNavigationController = UINavigationController(rootViewController: myOrdersViewController)
        
        return myOrdersViewController
    }
}

extension MyOrdersCoordinator: MyOrdersViewModelDelegate {
    
}
