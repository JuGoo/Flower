//
//  MainViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 23/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func mainViewDidClickLogout(_ mainViewModel: MainViewModel)
    func mainViewDidClickToPay(_ mainViewModel: MainViewModel)
    func mainView(_ mainViewModel: MainViewModel, didSelectContest contest: Any)
    func mainView(_ mainViewModel: MainViewModel, didSelectMedia media: Any)
}

protocol MainViewControllerDelegate: class {
    func mainViewControllerDidClick(_ mainViewController: MainViewController)
    func mainViewController(_ mainViewController: MainViewController, didSelectContest contest: Any)
}

class MainViewController: UIViewController {

    private(set) var viewModel: MainViewModelType
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: MainViewControllerDelegate?
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "OrderableTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "orderableCell")

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Panier", style: .done, target: self, action: #selector(MainViewController.payAction))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func payAction() {
        
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let startersAndDrinks = viewModel.startersAndDrinks, let orderable = ((Array(startersAndDrinks)[indexPath.section].value?[indexPath.row])) {
            self.viewModel.addOneMore(orderable: orderable)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "orderableCell") as? OrderableTableViewCell
        
        if let startersAndDrinks = viewModel.startersAndDrinks, let orderable = ((Array(startersAndDrinks)[indexPath.section].value?[indexPath.row])) {
            cell?.configure(orderable)
        }
        return cell ?? UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.startersAndDrinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let startersAndDrinks = viewModel.startersAndDrinks else {
            return 0
        }
        return Array(startersAndDrinks)[section].value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let startersAndDrinks = viewModel.startersAndDrinks else {
            return ""
        }
        return Array(startersAndDrinks)[section].key
    }
    
}
