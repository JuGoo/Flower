//
//  OrderableTableViewCell.swift
//  Flower
//
//  Created by Julien Gourdet on 25/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

class OrderableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var widthMarkViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var item: Orderable? {
        didSet {
            guard let item = item else {
                return
            }
            
            self.nameLabel?.text = item.name
            self.priceLabel?.text = "\(item.price)€"
            self.updateCountLabel(value: item.count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func updateCountLabel(value: Int) {
        self.counterLabel.isHidden = (value == 0)
        self.counterLabel.text = "\(value)x"
        self.counterLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5) {
            self.counterLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) //Scale label area
        }
    }
}

extension OrderableTableViewCell: CellIdentifiable {}
