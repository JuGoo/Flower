//
//  GetListCardService.swift
//  Flower
//
//  Created by Julien Gourdet on 26/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import Foundation
import Security

protocol ReadableDatabase {
    func loadCards() -> [Card?]
//    func loadObject<T: Model>(withID id: String) -> T?
}
protocol WritableDatabase {
    func save(_ card: Card)
}

typealias Database = ReadableDatabase & WritableDatabase

class KeyChain {
    
    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}

extension KeyChain: Database {
    
    func loadCards() -> [Card?] {
        var list: [Card?] = []
        if let receivedData = KeyChain.load(key: "CreditCard1") {
            let creditCard1 = NSKeyedUnarchiver.unarchiveObject(with: receivedData) as? Card
            print("result: ", creditCard1)
            list.append(creditCard1)
        }
//        if let data1 = UserDefaults.standard.object(forKey: "CreditCard1") as? Data {
//            let creditCard1 = NSKeyedUnarchiver.unarchiveObject(with: data1) as? Card
//            list.append(creditCard1)
//        }
//        if let data2 = UserDefaults.standard.object(forKey: "CreditCard2") as? Data {
//            let creditCard2 = NSKeyedUnarchiver.unarchiveObject(with: data2) as? Card
//            list.append(creditCard2)
//        }
        
        return list
    }
    
    func save(_ card: Card) {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: card)
        
        let status = KeyChain.save(key: "CreditCard1", data: archivedObject)
        print("status: ", status)
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(archivedObject, forKey: "CreditCard1")
//        userDefaults.synchronize()
    }
}

protocol GetListCardServiceProtocol {
    func loadCardsSaved() -> [Card]
}

struct GetListCardService: GetListCardServiceProtocol {
    
    private let database: ReadableDatabase
    typealias Model = Card
    
    init(_ database: ReadableDatabase = KeyChain()) {
        self.database = database
    }
    
    func loadCardsSaved() -> [Card] {
        let listCard: [Card?] = database.loadCards()
        return listCard.flatMap({ $0 })
    }
}


protocol SaveCardServiceProtocol {
    func saveCard(card: Card, completion:(_ result: Bool) -> Void)
}

struct SaveCardService: SaveCardServiceProtocol {
    
    private let database: WritableDatabase
    typealias Model = Card
    
    init(_ database: WritableDatabase = KeyChain()) {
        self.database = database
    }
    
    func saveCard(card: Card, completion:(_ result: Bool) -> Void) {
        self.database.save(card)
        completion(true)
    }
}
