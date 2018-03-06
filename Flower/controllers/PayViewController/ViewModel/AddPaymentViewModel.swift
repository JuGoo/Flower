//
//  AddPaymentViewModel.swift
//  Flower
//
//  Created by Julien Gourdet on 30/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit


protocol AddPaymentViewModelDelegate: class {
    //    func addPaymentView(_ addPaymentViewModel: AddPaymentViewModel, didSelectMedia media: Media)
    func addPaymentView(_ addPaymentViewModel: AddPaymentViewModel, didCreateCard card: Card)
    func addPaymentViewDidClickCancel(_ addPaymentViewModel: AddPaymentViewModel)
    //    func addPaymentView(_ addPaymentViewModel: AddPaymentViewModel, didClickViewOnIG media: Media)
}

protocol AddPaymentViewModelType {
    func didClickCancel()
    func didClickAdd()
}

class AddPaymentViewModel: AddPaymentViewModelType {
    weak var delegate: AddPaymentViewModelDelegate?
    var service: SaveCardServiceProtocol = SaveCardService()
    
    func didClickCancel() {
        self.delegate?.addPaymentViewDidClickCancel(self)
    }
    
    func didClickAdd() {
        let card = CreditCard()
        service.saveCard(card: card) { (success) in
            self.delegate?.addPaymentView(self, didCreateCard: card)
        }
        
    }
}
