//
//  Snack.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import Foundation

enum Temperature {
    case Cold
    case Hot
}

protocol Eatable {
    var temperature: Temperature { get set }
}

class Snack: Orderable, Eatable {
    var name: String
    var price: Float
    var count: Int
    var temperature: Temperature
    
    init(name: String, price: Float, count: Int = 0, temperature: Temperature) {
        self.name = name
        self.price = price
        self.count = count
        self.temperature = temperature
    }
}
