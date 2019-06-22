//
//  FavoriteHallCell.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/14/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class FavoriteHallCell: UICollectionViewCell {
    weak var delegete: removeFromFavoriteProtocol?
    
    var hall : Hall? {
        didSet{
            guard let bassedHall = hall else { return }
            nameLabel.text = bassedHall.hallName
            priceLabel.text = "\(bassedHall.hallPrice!) EGP"
            ratesLabel.text = "\(bassedHall.hallRatesCounter!) Rates"
        }
    }
    
    @objc func heartImageTapped(){
        delegete?.removeFromFavoriteButton(self)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(heartImageTapped)))
    }

}
