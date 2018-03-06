//
//  ListCreditCardViewController.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol ListCreditCardViewModelType: TableViewDataDelegate {
    var reloadSections: ((_ section: Int) -> Void)? { get set }
    func didAddCardClick()
    func didPayClick()
    var items: [ListCardViewModelItem] { get }
}

protocol ListCreditCardViewModelDelegate: class {
    func listCreditCardDidAddCardClick(_ listCreditCardViewModel: ListCreditCardViewModel)
    func listCreditCardDidClickToPay(_ listCreditCardViewModel: ListCreditCardViewModel)
//    func mainView(_ orderViewModel: OrderViewModel, didSelectContest contest: Any)
//    func mainView(_ orderViewModel: OrderViewModel, didSelectMedia media: Any)
}

class ListCreditCardViewController: UIViewController {
    
    private(set) var viewModel: ListCreditCardViewModelType
    @IBOutlet weak var cardsTableView: UITableView!
//    weak var delegate: ListCreditCardViewModelDelegate?
    
    init(viewModel: ListCreditCardViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.cardsTableView.beginUpdates()
            self?.cardsTableView.reloadSections([section], with: .fade)
            self?.cardsTableView.endUpdates()
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pay", style: .done, target: self, action: #selector(ListCreditCardViewController.payAction))
        setUpPayItem(isEnabled: false)
        
        setUpTableView()
    }

    func setUpTableView() {
        self.cardsTableView?.estimatedRowHeight = 50
        self.cardsTableView?.rowHeight = UITableViewAutomaticDimension
        self.cardsTableView?.sectionHeaderHeight = 30
        self.cardsTableView?.separatorStyle = .none
        
        self.cardsTableView?.dataSource = viewModel
        self.cardsTableView?.delegate = self
        
        self.cardsTableView.register(AddCardTableViewCell.nib, forCellReuseIdentifier: AddCardTableViewCell.identifier)
        self.cardsTableView.register(ValidCardTableViewCell.nib, forCellReuseIdentifier: ValidCardTableViewCell.identifier)
    }
    
    func setUpPayItem(isEnabled: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
    @objc func payAction() {
        self.viewModel.didPayClick()
    }
}


// MARK: - UITableViewDelegate
extension ListCreditCardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.section]
        //        if let cell = tableView.cellForRow(at: indexPath) as? OrderableTableViewCell{
        switch item.type {
        case .add:
            setUpPayItem(isEnabled: false)
            self.viewModel.didAddCardClick()
//            self.didAddCardClick()
            //                self.di
            //                let item =  item as? OrderableViewModelSnacksItem
            //                item?.snacks[indexPath.row].count += 1
            //                cell.item = item?.snacks[indexPath.row]
            break
        case .valid:
            setUpPayItem(isEnabled: true)
//            self.didAddCardClick()
            break
        }
        //        }
    }
    
}
