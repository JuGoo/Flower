//
//  Order.swift
//  Flower
//
//  Created by Julien Gourdet on 24/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol Orderable {
    var name: String { get set }
    var price: Float { get set }
}

enum Diet {
    case Alcohol
    case Soft
}

protocol Drinkable {
    var diet: Diet { get set }
}

struct Drink: Orderable, Drinkable {
    var name: String
    var price: Float
    var diet: Diet
}

enum Temperature {
    case Cold
    case Hot
}

protocol Eatable {
    var temperature: Temperature { get set }
}

struct Snack: Orderable, Eatable {
    var name: String
    var price: Float
    var temperature: Temperature
}
