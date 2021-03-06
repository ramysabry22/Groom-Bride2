
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import NotificationCenter
import SCLAlertView
import SVProgressHUD
import Kingfisher
import Alamofire

class SignInController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setupView()
        SetupComponentDelegetes()
        setupSignUpLabel()
        setupForgotPasswordLabel()
        ShowVisibleButton()
    }
    
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func SignInUser(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        SVProgressHUD.show()
        ApiManager.sharedInstance.signIn(email: email, password: password) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.dismiss(animated: true, completion: nil)
            }else{
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    
    
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = (dontHaveAccountLabel.text)!
        let range = (text as NSString).range(of: "Sign Up")
        if sender.didTapAttributedTextInLabel(label: dontHaveAccountLabel, inRange: range){
           
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "signUpScreen") as! SignUpController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @objc func ForgotPasswordAction(_ sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "forgotPasswordScreen") as! ForgetPasswordController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    func setupSignUpLabel(){
        dontHaveAccountLabel.text = "Don't have account? Sign Up"
        let text = (dontHaveAccountLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        
        let range = (text as NSString).range(of: "Sign Up")
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.mainAppPink(),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        underlineAttriString.addAttributes(strokeTextAttributes, range: range)
        dontHaveAccountLabel.attributedText = underlineAttriString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        dontHaveAccountLabel.addGestureRecognizer(tap)
        dontHaveAccountLabel.isUserInteractionEnabled = true
    }
    func setupForgotPasswordLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordAction(_ :)))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
    }
    @IBAction func SignInButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        checkEmptyFields()
    }
    func SetupComponentDelegetes(){
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func checkEmptyFields(){
        guard let _ = emailTextField.text,  !(emailTextField.text?.isEmpty)! , emailTextField.text?.isValidEmail() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Not valid email!", buttonTitle: "OK") {
            }
            return
        }
        guard let _ = passwordTextField.text,  !(passwordTextField.text?.isEmpty)! , passwordTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter your password!", buttonTitle: "OK") {
            }
            return
        }
        
          SignInUser()
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
