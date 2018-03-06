//
//  ListCreditCardViewModel.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

enum ListCardViewModelItemType {
    case add
    case valid
}

protocol ListCardViewModelItem {
    var type: ListCardViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
extension ListCardViewModelItem {
    var rowCount: Int {
        get {
            return 1
        }
    }
}

struct ListCardViewModelAddItem: ListCardViewModelItem {
    
    var type: ListCardViewModelItemType {
        return .add
    }
    
    var sectionTitle: String {
        return "Add"
    }
    
    var rowCount: Int {
        return 1
    }
}


struct ListCardViewModelValidCardItem: ListCardViewModelItem {
    
    var type: ListCardViewModelItemType {
        return .valid
    }
    
    var sectionTitle: String {
        return "Card"
    }
    
    var rowCount: Int {
        return cards.count
    }
    
    var cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
}

class ListCreditCardViewModel: NSObject, ListCreditCardViewModelType {
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    var listCardservice: GetListCardServiceProtocol = GetListCardService()
    var payService: PayServiceProtocol = PayService()
    
    var items = [ListCardViewModelItem]()
    // used by AppCoordinator
    weak var delegate: ListCreditCardViewModelDelegate?
    
    override init() {
        super.init()
        self.loadCards()
    }
    
    private func loadCards() {
        let cardList = self.listCardservice.loadCardsSaved()
        
        let addItem = ListCardViewModelAddItem()
        items.append(addItem)
        
        if !cardList.isEmpty {
            let cardsItem = ListCardViewModelValidCardItem(cards: cardList)
            items.append(cardsItem)
        }
    }
    
    func didAddCardClick() {
        self.delegate?.listCreditCardDidAddCardClick(self)
    }
    
    func didPayClick() {
        payService.pay { (result) in
            switch result {
            case let .success(value):
                print("Result of division is \(value)")
                self.delegate?.listCreditCardDidClickToPay(self)
            case let .error(error):
                print("error: \(error)")
            }
        }
    }

}

// MARK: - UITableViewDataSource

extension ListCreditCardViewModel: UITableViewDataSource {
    
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
        case .add:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddCardTableViewCell.identifier, for: indexPath) as? AddCardTableViewCell
//                ,
//                let item =  item as? OrderableViewModelSnacksItem
            {
//                cell.item = item.snacks[indexPath.row]
                return cell
            }
        case .valid:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ValidCardTableViewCell.identifier, for: indexPath) as? ValidCardTableViewCell
//                ,
//                let item =  item as? OrderableViewModelDrinksItem
                {
//                cell.item = item.drinks[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
}
