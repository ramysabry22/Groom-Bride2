//
//  FilterCell.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/13/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell, CategoryCellView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(category: HallCategory) {
        titleLabel.text = category.name
        imageView.image = UIImage(named: category.image!)?.withRenderingMode(.alwaysTemplate)
        backgroundColor = UIColor.clear
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                titleLabel.textColor = UIColor.mainAppPink()
                imageView.tintColor = UIColor.mainAppPink()
            }else{
                titleLabel.textColor = UIColor.darkGray
                imageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
