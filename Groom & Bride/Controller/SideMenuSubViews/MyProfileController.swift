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
        setupNavigationBar()
      NameTextField.text = "Ramy Ayman Sabry"
       
    }
    

    @IBAction func ChangePasswordButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordController
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func ApplyChangesButton(_ sender: UIButton) {
        print("Apply changes button")
        
        
    }

    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON77777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.mainAppPink()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
}
