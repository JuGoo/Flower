//
//  OrderCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol OrderCoordinatorDelegate: class {
    func orderCoordinatorDelegateDidLogout(_ orderCoordinator: OrderCoordinator)
}

class OrderCoordinator: NSObject, NavigationCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: OrderCoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        self.showOrderViewController()
    }
    
    private func initOrderViewController() -> OrderViewController {
        let orderViewModel = OrderViewModel()
        let orderViewController = OrderViewController(viewModel: orderViewModel)
        orderViewModel.delegate = self
        return orderViewController
    }
    
    fileprivate func showOrderViewController() {
        self.navigationController.pushViewController(initOrderViewController(), animated: false)
    }
}

extension OrderCoordinator: OrderViewModelDelegate {
    func mainViewDidClickLogout(_ orderCoordinator: OrderViewModel) {
        self.delegate?.orderCoordinatorDelegateDidLogout(self)
    }

    func mainViewDidClickToPay(_ orderCoordinator: OrderViewModel) {
        print("toto")
        
        let payCoordinator = PayCoordinator(navigationController: navigationController
//            , contest: contest, pageType: pageType
        )
        payCoordinator.start()
        self.addChildCoordinator(payCoordinator)
    }

    func mainView(_ orderCoordinator: OrderViewModel, didSelectContest contest: Any) {
//        let viewContestCoordinator = ViewContestCoordinator(navigationController: navigationController, contest: contest, pageType: pageType)
//        viewContestCoordinator.start()
//        self.addChildCoordinator(viewContestCoordinator)
    }

    func mainView(_ orderCoordinator: OrderViewModel, didSelectMedia media: Any){
//        let contest = Contest(name: "Contest Name", media: media)
//        let viewContestCoordinator = ViewContestCoordinator(navigationController: navigationController, contest: contest, pageType: pageType)
//        viewContestCoordinator.start()
//        self.addChildCoordinator(viewContestCoordinator)
    }
}

//extension OrderCoordinator: CreateContestCoordinatorDelegate {
//    func createContestCoordinatorDelegateDidCancel(_ createContestCoordinator: CreateContestCoordinator) {
//        self.navigationController.dismiss(animated: true, completion: nil)
//        self.removeChildCoordinator(createContestCoordinator)
//    }
//
//    func createContestCoordinator(_ createContestCoordinator: CreateContestCoordinator, didCreateContest contest: Contest) {
//        self.navigationController.dismiss(animated: true, completion: nil)
//        self.removeChildCoordinator(createContestCoordinator)
//    }
//}

extension OrderCoordinator: UINavigationControllerDelegate {
    // Handling back navigation from a sub-navigation-flow
    // http://khanlou.com/2017/05/back-buttons-and-coordinators/
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // ensure the view controller is popping
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }
        
        // clean out ViewContestCoordinator from child coordinators
//        if fromViewController is ContestViewController {
//            childCoordinators = childCoordinators.filter { !($0.self is ViewContestCoordinator) }
//        }
    }
}
