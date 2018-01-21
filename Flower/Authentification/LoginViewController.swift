//
//  LoginViewController.swift
//  Flower
//
//  Created by Julien on 21/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func didSuccessfullyLogin()
    func didChooseSignup()
}

protocol LoginViewModelType { }

struct LoginViewModel: LoginViewModelType { }

final class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    let viewModel: LoginViewModelType
    
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    @IBAction func loginAction(_ sender: Any) {
        delegate?.didSuccessfullyLogin()
    }
    
    
    @IBAction func signupAction(_ sender: Any) {
        delegate?.didChooseSignup()
    }
}
