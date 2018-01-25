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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        if selected {
            UIView.animate(withDuration: 0.5) {
                self.widthMarkViewConstraint.constant = 5
                self.contentView.layoutIfNeeded()
            }
        }
    }
    
    func configure(_ orderable: Orderable) {
        self.widthMarkViewConstraint.constant = (orderable.count == 0) ? 0 : 5
        self.updateCountLabel(value: orderable.count)
        self.nameLabel.text = orderable.name
        self.priceLabel.text = "\(orderable.price)€"
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
