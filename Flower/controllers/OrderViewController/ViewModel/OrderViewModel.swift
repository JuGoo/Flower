//
//  OrderViewModel.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

typealias TableViewDataDelegate = UITableViewDelegate & UITableViewDataSource

protocol OrderViewModelType: TableViewDataDelegate {
    var reloadSections: ((_ section: Int) -> Void)? { get set }
    func didBasketClick()
}

enum OrderableViewModelItemType {
    case drink
    case snack
}

protocol OrderableViewModelItem {
    var type: OrderableViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
extension OrderableViewModelItem {
    var rowCount: Int {
        get {
            return 1
        }
    }    
}

struct OrderableViewModelDrinksItem: OrderableViewModelItem {
    
    var type: OrderableViewModelItemType {
        return .drink
    }
    
    var sectionTitle: String {
        return "Drinks"
    }
    
    var rowCount: Int {
        return drinks.count
    }
    
    var drinks: [Orderable]
    
    init(drinks: [Orderable]) {
        self.drinks = drinks
    }
}

struct OrderableViewModelSnacksItem: OrderableViewModelItem {
    
    var type: OrderableViewModelItemType {
        return .snack
    }
    
    var sectionTitle: String {
        return "Snacks"
    }
    
    var rowCount: Int {
        return snacks.count
    }
    
    var snacks: [Orderable]
    
    init(snacks: [Orderable]) {
        self.snacks = snacks
    }
    
}


class OrderViewModel: NSObject, OrderViewModelType {
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    var items = [OrderableViewModelItem]()
    var service: GetListOrderableServiceProtocol = GetListOrderableService()
    
    // used by AppCoordinator
    weak var delegate: OrderViewModelDelegate?
    
    override init() {
        super.init()
        self.loadStartersAndDrinks()
    }
    
    func loadStartersAndDrinks() {
        let barList = self.service.loadStartersAndDrinks()
        
        let drinks: [Drink]? = barList.filter { return $0 is Drinkable } as? [Drink]
        if let drinks = drinks, !drinks.isEmpty {
            let drinksItem = OrderableViewModelDrinksItem(drinks: drinks)
            items.append(drinksItem)
        }
        let snacks: [Snack]? = barList.filter { return $0 is Snack } as? [Snack]
        if let snacks = snacks, !snacks.isEmpty {
            let snacksItem = OrderableViewModelSnacksItem(snacks: snacks)
            items.append(snacksItem)
        }
    }
    
    func didBasketClick() {
        self.delegate?.mainViewDidClickToPay(self)
    }
}

// MARK: - UITableViewDataSource

extension OrderViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        return item.rowCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .snack:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OrderableTableViewCell.identifier, for: indexPath) as? OrderableTableViewCell,
                let item =  item as? OrderableViewModelSnacksItem {
                cell.item = item.snacks[indexPath.row]
                return cell
            }
        case .drink:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OrderableTableViewCell.identifier, for: indexPath) as? OrderableTableViewCell,
                let item =  item as? OrderableViewModelDrinksItem {
                cell.item = item.drinks[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
}

// MARK: - UITableViewDelegate
extension OrderViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        if let cell = tableView.cellForRow(at: indexPath) as? OrderableTableViewCell{
            switch items[indexPath.section].type {
            case .snack:
                let item =  item as? OrderableViewModelSnacksItem
                item?.snacks[indexPath.row].count += 1
                cell.item = item?.snacks[indexPath.row]
                break
            case .drink:
                let item =  item as? OrderableViewModelDrinksItem
                item?.drinks[indexPath.row].count += 1
                cell.item = item?.drinks[indexPath.row]
                break
            }
        }
    }
    
}

