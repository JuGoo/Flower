//
//  OrderViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol OrderViewModelDelegate: class {
    func mainViewDidClickLogout(_ orderViewModel: OrderViewModel)
    func mainViewDidClickToPay(_ orderViewModel: OrderViewModel)
    func mainView(_ orderViewModel: OrderViewModel, didSelectContest contest: Any)
    func mainView(_ orderViewModel: OrderViewModel, didSelectMedia media: Any)
}

protocol OrderViewControllerDelegate: class {
    func orderViewControllerDidClick(_ orderViewController: OrderViewController)
    func orderViewController(_ orderViewController: OrderViewController, didSelectContest contest: Any)
}

class OrderViewController: UIViewController {

    private(set) var viewModel: OrderViewModelType
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: OrderViewControllerDelegate?
    
    init(viewModel: OrderViewModelType) {
        self.viewModel = viewModel        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Panier", style: .done, target: self, action: #selector(OrderViewController.payAction))
        
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([section], with: .fade)
            self?.tableView.endUpdates()
        }
        
        setUpTableView()
    }
    
    @objc func payAction() {
        self.viewModel.didBasketClick()
        delegate?.orderViewControllerDidClick(self)
    }
    
    func setUpTableView() {
        tableView?.estimatedRowHeight = 50
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.sectionHeaderHeight = 30
        tableView?.separatorStyle = .none
        
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        
        self.tableView.register(OrderableTableViewCell.nib, forCellReuseIdentifier: OrderableTableViewCell.identifier)
    }
}
