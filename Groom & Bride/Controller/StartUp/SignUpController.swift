
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import NotificationCenter
import SCLAlertView
import SVProgressHUD
import Kingfisher
import Alamofire

class SignUpController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setupView()
        SetupComponentDelegetes()
        ShowVisibleButton()
    }
    
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func AddNewuser(){
        guard let name = userNameTextField.text ,let email = emailTextField.text, let password = passwordTextField.text  else {
                return
            }
        SVProgressHUD.show()
        ApiManager.sharedInstance.signUp(email: email, name: name, password: password) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.dismiss(animated: true, completion: nil)
            }else{
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK") {
                }
            }
        }
        
    }

    
    @IBAction func BackButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SignUpButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        checkEmptyFields()
    }
    func SetupComponentDelegetes(){
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func checkEmptyFields(){
        guard let _ = userNameTextField.text,  !(userNameTextField.text?.isEmpty)! , userNameTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter your name!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = emailTextField.text,  !(emailTextField.text?.isEmpty)! , emailTextField.text?.isValidEmail() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Not valid email!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = passwordTextField.text,  !(passwordTextField.text?.isEmpty)!, passwordTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter your password!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = passwordTextField.text,  passwordTextField.text?.count ?? 0 > 5  else {
            self.show1buttonAlert(title: "Error", message: "Password must be at least 6 characters!", buttonTitle: "OK") {
            }
            return
        }
        
        AddNewuser()
    }
    
    
    
    
    //     MARK :- eye button on textfield
/**********************************************************************************************/
    func ShowVisibleButton(){
        view.addSubview(rightButtonToggle)
        rightButtonToggle.anchor(top: nil, leading: nil, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 13), size: CGSize(width: 22, height: 22))
        rightButtonToggle.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 0).isActive = true
    }
    let rightButtonToggle: UIButton = {
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width: 25, height: 25)
        rightButton.setBackgroundImage(UIImage(named: "HidePasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "ShowPasswordICON777")?.withRenderingMode(.alwaysTemplate), for: .selected)
        rightButton.isSelected = false
        rightButton.tintColor = UIColor.gray
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        rightButton.addTarget(self, action: #selector(PasswordTogglekButtonAction), for: .touchUpInside)
        return rightButton
    }()
    
    var secure = false
    @objc func PasswordTogglekButtonAction(){
        if(secure == false) {
            passwordTextField.isSecureTextEntry = false
            rightButtonToggle.isSelected = true
        } else {
            passwordTextField.isSecureTextEntry = true
            rightButtonToggle.isSelected = false
        }
        secure = !secure
    }
}

