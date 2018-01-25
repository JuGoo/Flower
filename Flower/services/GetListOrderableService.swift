//
//  GetListOrderableService.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol GetListOrderableServiceProtocol {
    func loadStartersAndDrinks() -> [Orderable]
}

class GetListOrderableService: GetListOrderableServiceProtocol {
    
    func loadStartersAndDrinks() -> [Orderable] {
        let orangeJuice = Drink(name: "Orange Juice", price: 5.0, diet: .Soft)
        let appleJuice = Drink(name: "Apple Juice", price: 5.0, diet: .Soft)
        let perryJuice = Drink(name: "Perry Juice", price: 5.0, diet: .Soft)
        let cranberryJuice = Drink(name: "Cranberry Juice", price: 5.0, diet: .Soft)
        
        let beer = Drink(name: "Beer", price: 5.0, diet: .Alcohol)
        let mojito = Drink(name: "Mojito", price: 7.0, diet: .Alcohol)
        let vodkaMartini = Drink(name: "Vodka martini", price: 8.0, diet: .Alcohol)
        let vesper = Drink(name: "Vesper", price: 10.0, diet: .Alcohol)
        let rumCollins = Drink(name: "Rum Collins", price: 12.0, diet: .Alcohol)
        let mintJulep = Drink(name: "Mint Julep", price: 19.0, diet: .Alcohol)
        
        let onionRings = Snack(name: "Onion Rings", price: 4.0, temperature: .Hot)
        let cheesyFries = Snack(name: "Cheesy Fries", price: 4.0, temperature: .Hot)
        let pulledPorkTacos = Snack(name: "Pulled Pork Tacos", price: 12.0, temperature: .Hot)
        
        let ceasarSalad = Snack(name: "Ceasar Salad", price: 10.0, temperature: .Cold)
        let vegSalad = Snack(name: "Veg Salad", price: 10.0, temperature: .Cold)
        
        
        let barList: [Orderable] = [orangeJuice, appleJuice, perryJuice, cranberryJuice, beer, mojito, vodkaMartini, vesper, rumCollins, mintJulep, onionRings, cheesyFries, pulledPorkTacos, ceasarSalad, vegSalad]
        
        return barList
    }
}
