//
//  SignupViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol SignupViewControllerDelegate: class {
    func didCompleteSignup()
}

protocol SignupViewModelType { }

struct SignupViewModel: SignupViewModelType { }

class SignupViewController: UIViewController {

    weak var delegate: SignupViewControllerDelegate?
    let viewModel: SignupViewModelType
    
    init(viewModel: SignupViewModelType) {
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
        self.title = NSLocalizedString("create.account.title", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAction(_ sender: Any) {
        delegate?.didCompleteSignup()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
