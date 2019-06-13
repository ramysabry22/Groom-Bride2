//
//  MyProfileController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/12/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class MyProfileController: UIViewController {

   
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      NameTextField.text = "Ramy Ayman Sabry"
       
    }
    

    @IBAction func ChangePasswordButtonAction(_ sender: UIButton) {
        print("Change password button tapped")
        
        
    }
    @IBAction func ApplyChangesButton(_ sender: UIButton) {
        print("Apply changes button")
        
        
    }


}
