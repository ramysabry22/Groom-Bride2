//
//  HallCell.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/13/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class HallCell: UICollectionViewCell, HomeHallsCellsVIew{
    
    func configure(hall: Hall) {
        nameLabel.text = hall.hallName
        priceLabel.text = "\(Int(hall.hallPrice!)) EGP"
        ratesLabel.text = "(\(Int(hall.hallRatesCounter!))) Rating"
        ratingStarsView.rating = Double(Int(hall.hallRate ?? 0))
        imageView.image = UIImage(named: "AppLogoImage")
        
        if hall.hallImage.isEmpty == false && hall.hallImage.count > 0 {
            let url = URL(string: "\(hall.hallImage[0])")
            let tempImageView : UIImageView! = UIImageView()
            tempImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                if result.isSuccess == false{
                    self.imageView.image = UIImage(named: "logo1")
                }else{
                    self.imageView.image = tempImageView.image
                }
            }
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
