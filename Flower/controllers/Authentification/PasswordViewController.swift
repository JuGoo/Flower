//
//  PasswordViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 24/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol PasswordViewControllerDelegate: class {
    func didCompletePassword()
}

protocol PasswordViewModelType { }

struct PasswordViewModel: PasswordViewModelType { }

class PasswordViewController: UIViewController {

    weak var delegate: PasswordViewControllerDelegate?
    let viewModel: PasswordViewModelType
    
    init(viewModel: PasswordViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("create.password.title", comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validPasswordAction(_ sender: Any) {
        delegate?.didCompletePassword()
    }

}
