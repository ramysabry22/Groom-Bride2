
import UIKit
import SVProgressHUD
import Alamofire

class ChangePasswordController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var RePasswordTextField: UITextField!
    @IBOutlet weak var OldPasswordTextField: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        ShowVisibleButton()
        setupComponent()
        SVProgressHUD.setupView()
    }
    
    func resetPassword(oldPassword: String, newPassword: String, rePassword: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.changePassword(oldPassword: oldPassword, newPassword: newPassword, reNewPassword: rePassword) { (valid, msg, reRequest) in
            self.dismissRingIndecator()
            if reRequest {
                self.resetPassword(oldPassword: oldPassword, newPassword: newPassword, rePassword: rePassword)
            }
            else if valid {
                self.show1buttonAlert(title: "Password changed", message: "Password changed sucessfully", buttonTitle: "OK", callback: {
                })
            }else if !valid {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    @IBAction func ResetPasswordButton(_ sender: UIButton) {
        guard let oldPassword = OldPasswordTextField.text,  !(OldPasswordTextField.text?.isEmpty)! , OldPasswordTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter old password!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = OldPasswordTextField.text, OldPasswordTextField.text?.count ?? 0 > 5 else {
            self.show1buttonAlert(title: "Error", message: "Old must be at least 6 characters!", buttonTitle: "OK") {
            }
            return
        }
        guard let newPassword = NewPasswordTextField.text,  !(NewPasswordTextField.text?.isEmpty)! , NewPasswordTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter old password!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = NewPasswordTextField.text, NewPasswordTextField.text?.count ?? 0 > 5 else {
            self.show1buttonAlert(title: "Error", message: "Old must be at least 6 characters!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = RePasswordTextField.text,  !(RePasswordTextField.text?.isEmpty)! , RePasswordTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter old password!", buttonTitle: "OK") {
            }
            return
        }
        guard let rePassword = RePasswordTextField.text, RePasswordTextField.text?.count ?? 0 > 5 else {
            self.show1buttonAlert(title: "Error", message: "Old must be at least 6 characters!", buttonTitle: "OK") {
            }
            return
        }
        if NewPasswordTextField.text != RePasswordTextField.text {
            self.show1buttonAlert(title: "Error", message: "Password doesn't match!", buttonTitle: "OK") {
            }
            return
        }
        
        resetPassword(oldPassword: oldPassword, newPassword: newPassword, rePassword: rePassword)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func setupComponent(){
        OldPasswordTextField.delegate = self
        NewPasswordTextField.delegate = self
        RePasswordTextField.delegate = self
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
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
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
