//
//  ChangePasswordController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/12/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {

    @IBOutlet weak var RePasswordTextField: UITextField!
    @IBOutlet weak var OldPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowVisibleButton()
        
    }
    
    @IBAction func ResetPasswordButton(_ sender: UIButton) {
        print("reset password button")
        
        
    }
    


    //     MARK :- eye button on textfield
/**********************************************************************************************/
    func ShowVisibleButton(){
        view.addSubview(rightButtonToggle1)
        rightButtonToggle1.anchor(top: nil, leading: nil, bottom: nil, trailing: OldPasswordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 13), size: CGSize(width: 22, height: 22))
        rightButtonToggle1.centerYAnchor.constraint(equalTo: OldPasswordTextField.centerYAnchor, constant: 0).isActive = true
        
        view.addSubview(rightButtonToggle2)
        rightButtonToggle2.anchor(top: nil, leading: nil, bottom: nil, trailing: NewPasswordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 13), size: CGSize(width: 22, height: 22))
        rightButtonToggle2.centerYAnchor.constraint(equalTo: NewPasswordTextField.centerYAnchor, constant: 0).isActive = true
        
        view.addSubview(rightButtonToggle3)
        rightButtonToggle3.anchor(top: nil, leading: nil, bottom: nil, trailing: RePasswordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 13), size: CGSize(width: 22, height: 22))
        rightButtonToggle3.centerYAnchor.constraint(equalTo: RePasswordTextField.centerYAnchor, constant: 0).isActive = true
    }
    let rightButtonToggle1: UIButton = {
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width: 25, height: 25)
        rightButton.setBackgroundImage(UIImage(named: "HidePasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "ShowPasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .selected)
        rightButton.isSelected = false
        rightButton.tintColor = UIColor.mainAppPink()
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        rightButton.addTarget(self, action: #selector(PasswordTogglekButtonAction), for: .touchUpInside)
        return rightButton
    }()
    let rightButtonToggle2: UIButton = {
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width: 25, height: 25)
        rightButton.setBackgroundImage(UIImage(named: "HidePasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "ShowPasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .selected)
        rightButton.isSelected = false
        rightButton.tintColor = UIColor.mainAppPink()
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        rightButton.addTarget(self, action: #selector(PasswordTogglekButtonAction), for: .touchUpInside)
        return rightButton
    }()
    let rightButtonToggle3: UIButton = {
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width: 25, height: 25)
        rightButton.setBackgroundImage(UIImage(named: "HidePasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "ShowPasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .selected)
        rightButton.isSelected = false
        rightButton.tintColor = UIColor.mainAppPink()
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        rightButton.addTarget(self, action: #selector(PasswordTogglekButtonAction), for: .touchUpInside)
        return rightButton
    }()
    
    var secure = false
    @objc func PasswordTogglekButtonAction(){
        if(secure == false) {
            OldPasswordTextField.isSecureTextEntry = false
            NewPasswordTextField.isSecureTextEntry = false
            RePasswordTextField.isSecureTextEntry = false
            rightButtonToggle1.isSelected = true
            rightButtonToggle2.isSelected = true
            rightButtonToggle3.isSelected = true
        } else {
            OldPasswordTextField.isSecureTextEntry = true
            NewPasswordTextField.isSecureTextEntry = true
            RePasswordTextField.isSecureTextEntry = true
            rightButtonToggle1.isSelected = false
            rightButtonToggle2.isSelected = false
            rightButtonToggle3.isSelected = false
        }
        secure = !secure
    }
}
