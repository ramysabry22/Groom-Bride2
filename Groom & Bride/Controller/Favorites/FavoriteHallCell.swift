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
    
    var favoriteHall : FavoriteHall? {
        didSet{
            guard let bassedHall = favoriteHall else { return }
            nameLabel.text = bassedHall.hallId.hallName
            priceLabel.text = "\(bassedHall.hallId.hallPrice!) EGP"
            ratesLabel.text = "\(bassedHall.hallId.hallsAverageRating!) Rates"
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
