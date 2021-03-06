//
//  HallCell.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/13/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import Cosmos

class HallCell: UICollectionViewCell {
    var hall : Hall? {
        didSet{
            guard let bassedHall = hall else { return }
            nameLabel.text = bassedHall.hallName
            priceLabel.text = "\(Int(bassedHall.hallPrice!)) EGP"
            ratesLabel.text = "(\(Int(bassedHall.hallRatesCounter!))) Rating"
            ratingStarsView.rating = Double(Int(bassedHall.hallRate ?? 0))
            imageView.image = UIImage(named: "AppLogoImage")
        }
    }
    
    
    @IBOutlet weak var ratingStarsView: CosmosView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
