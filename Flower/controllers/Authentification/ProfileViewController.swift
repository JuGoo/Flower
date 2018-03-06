//
//  ProfileViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class {
    func didSuccessfullyLogout()
//    func didChooseSignup()
}

protocol ProfileViewModelType { }

struct ProfileViewModel: ProfileViewModelType { }

class ProfileViewController: UIViewController {

    weak var delegate: ProfileViewControllerDelegate?
    let viewModel: ProfileViewModelType
    
    init(viewModel: ProfileViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deallocing \(self)")
    }

    @IBAction func logoutAction(_ sender: Any) {
        delegate?.didSuccessfullyLogout()
    }
}
