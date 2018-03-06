//
//  CellIdentifiable.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
    
    static var nib: UINib { get }
    
    static var identifier: String { get }
    
}

extension CellIdentifiable {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
