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
    func coordinatorDidCreateAccount(coordinator: AuthenticationCoordinator)
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
    
    func showSignupViewController(){
        let viewModel = SignupViewModel()
        let signup = SignupViewController(viewModel:viewModel)
        signup.delegate = self
        navigationController.show(signup, sender: self)
    }

    func showPasswordViewController(){
        let viewModel = PasswordViewModel()
        let password = PasswordViewController(viewModel:viewModel)
        password.delegate = self
        navigationController.show(password, sender: self)
    }
    
    func showSendEmailAlertController() {
        let alertController = UIAlertController(title: "See your mailbox", message: "An email was sending to xx@yopmail.com", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.navigationController.present(alertController, animated: true, completion: nil)
    }
    
}

extension AuthenticationCoordinator: LoginViewControllerDelegate {

    func didSuccessfullyLogin() {
        print(navigationController.childViewControllers)
        delegate?.coordinatorDidAuthenticate(coordinator: self)
    }

    func didChooseSignup() {
        print(navigationController.childViewControllers)
        showSignupViewController()
    }
    
    func didSuccessfullySendPassword() {
        print(navigationController.childViewControllers)
        showSendEmailAlertController()
    }
}

extension AuthenticationCoordinator: SignupViewControllerDelegate {
    
    func didCompleteSignup() {
        showPasswordViewController()
    }
}

extension AuthenticationCoordinator: PasswordViewControllerDelegate {
    
    func didCompletePassword() {
        delegate?.coordinatorDidCreateAccount(coordinator: self)
    }
}

