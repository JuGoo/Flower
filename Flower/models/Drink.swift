//
//  Drink.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import Foundation

enum Diet {
    case Alcohol
    case Soft
}

protocol Drinkable {
    var diet: Diet { get set }
}

class Drink: Orderable, Drinkable {
    var name: String
    var price: Float
    var count: Int
    var diet: Diet
    
    init(name: String, price: Float, count: Int = 0, diet: Diet) {
        self.name = name
        self.price = price
        self.count = count
        self.diet = diet
    }
}
