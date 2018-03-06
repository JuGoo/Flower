//
//  MyOrdersViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 30/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MyOrdersViewModelDelegate: class {
    
}

protocol MyOrdersViewModelType {
    weak var delegate: MyOrdersViewModelDelegate? { get }
}

class MyOrdersViewModel: MyOrdersViewModelType {
    weak var delegate: MyOrdersViewModelDelegate?
    
}

class MyOrdersViewController: UIViewController {
    
    private(set) var viewModel: MyOrdersViewModelType
    
    //    weak var delegate: AddPaymentMethodDelegate?
    
    init(viewModel: MyOrdersViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
