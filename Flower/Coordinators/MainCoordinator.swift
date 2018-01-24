//
//  MainCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: class {
    func mainCoordinatorDelegateDidLogout(_ mainCoordinator: MainCoordinator)
}

class MainCoordinator: NSObject, NavigationCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: MainCoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        self.showMainViewController()
    }
    
    private func initMainViewController() -> MainViewController {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
//        mainViewModel.delegate = self
        return mainViewController
    }
    
    fileprivate func showMainViewController() {
        self.navigationController.pushViewController(initMainViewController(), animated: false)
    }
}

extension MainCoordinator: MainViewModelDelegate {
    func mainViewDidClickLogout(_ mainViewModel: MainViewModel) {
        self.delegate?.mainCoordinatorDelegateDidLogout(self)
    }

    func mainViewDidClickCreateNewContest(_ mainViewModel: MainViewModel) {
//        let createContestNavigationController = UINavigationController()
//        let createContestCoordinator = CreateContestCoordinator(navigationController: createContestNavigationController)
//        createContestCoordinator.delegate = self
//        createContestCoordinator.start()
//        self.addChildCoordinator(createContestCoordinator)
//
//        self.navigationController.present(createContestNavigationController, animated: true, completion: nil)
    }

    func mainView(_ mainViewModel: MainViewModel, didSelectContest contest: Any) {
//        let viewContestCoordinator = ViewContestCoordinator(navigationController: navigationController, contest: contest, pageType: pageType)
//        viewContestCoordinator.start()
//        self.addChildCoordinator(viewContestCoordinator)
    }

    func mainView(_ mainViewModel: MainViewModel, didSelectMedia media: Any){
//        let contest = Contest(name: "Contest Name", media: media)
//        let viewContestCoordinator = ViewContestCoordinator(navigationController: navigationController, contest: contest, pageType: pageType)
//        viewContestCoordinator.start()
//        self.addChildCoordinator(viewContestCoordinator)
    }
}

//extension MainCoordinator: CreateContestCoordinatorDelegate {
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

extension MainCoordinator: UINavigationControllerDelegate {
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
