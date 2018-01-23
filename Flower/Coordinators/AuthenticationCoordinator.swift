//
//  AuthenticationCoordinator.swift
//  AccorBooking
//
//  Created by Julien Gourdet on 16/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func coordinatorDidAuthenticate(coordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: NSObject, NavigationCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: AuthenticationCoordinatorDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showLoginViewController()
    }
    
    private func initLoginViewController() -> LoginViewController {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewController.delegate = self
        return loginViewController
    }
    
    deinit {
        print("deallocing \(self)")
    }

    func showLoginViewController() {
        self.navigationController.setViewControllers([initLoginViewController()], animated: false)
    }
//    func showLoginViewController() {
//        loginViewController.delegate = self
//        navigationController.show(loginViewController, sender: self)
//    }
//
//    func showSignupViewController(){
//        let viewModel = SignupViewModel()
//        let signup = SignupViewController(viewModel:viewModel)
//        signup.delegate = self
//        navigationController.show(signup, sender: self)
//    }
//
//    func showPasswordViewController(){
////        let viewModel = PasswordViewModel()
////        let password = PasswordViewController(viewModel:viewModel)
////        password.delegate = self
////        navigationController.show(password, sender: self)
//    }
}

extension AuthenticationCoordinator: LoginViewControllerDelegate {

    func didSuccessfullyLogin() {
        print(navigationController.childViewControllers)
        delegate?.coordinatorDidAuthenticate(coordinator: self)
    }

    func didChooseSignup() {
        print(navigationController.childViewControllers)
//        showSignupViewController()
    }
}
//
//extension AuthenticationCoordinator: SignupViewControllerDelegate {
//    func didCompleteSignup() {
//        showPasswordViewController()
//    }
//}

//extension AuthenticationCoordinator: PasswordViewControllerDelegate {
//    func didSignupWithEmailAndPassword(email: String, passowrd: String) {
//        delegate?.coordinatorDidAuthenticate(coordinator: self)
//    }
//}

