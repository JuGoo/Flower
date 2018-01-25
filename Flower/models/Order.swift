//
//  Order.swift
//  Flower
//
//  Created by Julien Gourdet on 24/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import Foundation

protocol Orderable: class {
    var name: String { get set }
    var price: Float { get set }
    var count: Int { get set }
}
