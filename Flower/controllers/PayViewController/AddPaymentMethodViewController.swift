//
//  AddPaymentMethodViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 27/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit
import Eureka
import CreditCardRow

//protocol AddPaymentMethodDelegate: class {
//    func dismissClick()
//}


class AddPaymentMethodViewController: FormViewController {
    
    private(set) var viewModel: AddPaymentViewModelType
    
//    weak var delegate: AddPaymentMethodDelegate?
    
    init(viewModel: AddPaymentViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Append the default CreditCardRow and my custom MyCreditCardRow
        form +++ Section()
            <<< CreditCardRow()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(AddPaymentMethodViewController.disMiss))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(AddPaymentMethodViewController.addCard))
    }
    
    @objc func disMiss() {
        self.viewModel.didClickCancel()
    }
    
    @objc func addCard() {
        self.viewModel.didClickAdd()
    }
}
