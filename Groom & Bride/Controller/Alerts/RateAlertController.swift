//
//  RateAlertController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/28/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import Cosmos

class RateAlertController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var rateStarsView: CosmosView!
    
    var buttonAction: ((_ valid: Bool,_ rate: Int) -> ())?
    var finalRate: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.mainAppPink().cgColor
        
        rateStarsView.didFinishTouchingCosmos = { rating in
            self.finalRate = Int(rating)
            print(self.finalRate)
        }
    }

    @IBAction func RateButtonAction(_ sender: UIButton) {
        self.buttonAction?(true,finalRate)
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func CancelButtonAction(_ sender: UIButton) {
        self.buttonAction?(false,0)
        self.dismiss(animated: true) {
            
        }
    }
    

}
