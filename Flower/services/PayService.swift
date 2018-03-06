//
//  PayService.swift
//  Flower
//
//  Created by Julien Gourdet on 30/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

protocol PayServiceProtocol {
    func pay(completion: @escaping ((Result<Bool>) -> ()))
}

class PayService: PayServiceProtocol {
    
    func pay(completion: @escaping ((Result<Bool>) -> ())) {
        let random = Int(arc4random_uniform(1))
        if random%2 == 0 {
            completion(.success(true))
        } else {
            completion(.error("bad access"))
        }
    }
    
}
