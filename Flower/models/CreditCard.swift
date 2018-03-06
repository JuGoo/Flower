//
//  CreditCard.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

public enum CardType : String {
    case Visa           = "Visa"
    case MasterCard     = "MasterCard"
    case JCB            = "JCB"
    case Diners         = "Dinners Club"
    case Discover       = "Discover"
    case Amex           = "Amex"
    case Maestro        = "Maestro"
    case UnionPay       = "UnionPay"
    case Electron       = "Electron"
    case Dankort        = "Dankort"
    case RuPay          = "RuPay"
    case Unknown        = "Unknown"
}

public enum Month :String{
    case jan = "01"
    case Feb = "02"
    case Mar = "03"
    case Apr = "04"
    case May = "05"
    case Jun = "06"
    case Jul = "07"
    case Aug = "08"
    case Sep = "09"
    case Oct = "10"
    case Nov = "11"
    case Dec = "12"
    static let allValues :[String] = [jan.rawValue, Feb.rawValue, Mar.rawValue, Apr.rawValue, May.rawValue, Jun.rawValue, Jul.rawValue, Aug.rawValue, Sep.rawValue, Oct.rawValue, Nov.rawValue, Dec.rawValue]
    
}

//typealias Model = NSObject && NSCoding

protocol Card: NSCoding {
    var name: String? { get set }
    var number: String? { get set }
    var month: Month? { get set }
    var year: String? { get set }
    var cvc: String? { get set }
    var cardType: CardType? { get set }
}

class CreditCard: NSObject, Card {
    
    public var name: String?
    public var number: String?
    public var month: Month?
    public var year: String?
    public var cvc: String?
    public var cardType: CardType?
    
    override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String
        number = aDecoder.decodeObject(forKey: "number") as? String
    }
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(number, forKey: "number")
    }
}
