//
//  MainViewModel.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol MainViewModelType {
    var startersAndDrinks: Dictionary<String, [Orderable]?>? { get set }
    func addOneMore(orderable: Orderable)
}

enum OrderableType: String {
    case Drink = "Drink"
    case Snack = "Snack"
}

struct MainViewModel: MainViewModelType {
    
    var startersAndDrinks: [String: [Orderable]?]?
    var service: GetListOrderableServiceProtocol
    
    init(service: GetListOrderableServiceProtocol = GetListOrderableService()) {
        self.service = service
        self.startersAndDrinks = self.loadStartersAndDrinks()
    }
    
    func loadStartersAndDrinks() -> [String: [Orderable]?] {
        let barList = self.service.loadStartersAndDrinks()
        
        let drink: [Drink]? = barList.filter { return $0 is Drinkable } as? [Drink]
        
        let snack: [Snack]? = barList.filter { return $0 is Snack } as? [Snack]
        
        return [OrderableType.Drink.rawValue: drink, OrderableType.Snack.rawValue: snack]
    }
    
    func addOneMore(orderable: Orderable) {
        orderable.count += 1
    }
}
