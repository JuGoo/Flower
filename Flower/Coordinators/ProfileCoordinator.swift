//
//  ProfileCoordinator.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorDelegate: class {
    func coordinatorLogout(coordinator: ProfileCoordinator)
}

class ProfileCoordinator: NSObject, NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: ProfileCoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showProfileViewController()
    }
    
    private func initProfileViewController() -> ProfileViewController {
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        profileViewController.delegate = self
        return profileViewController
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func showProfileViewController() {
        self.navigationController.setViewControllers([initProfileViewController()], animated: false)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didSuccessfullyLogout() {
        print(navigationController.childViewControllers)
        self.delegate?.coordinatorLogout(coordinator: self)
    }
}

