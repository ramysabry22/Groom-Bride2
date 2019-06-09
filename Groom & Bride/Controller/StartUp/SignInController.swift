
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
        SVProgressHUD.setForegroundColor(UIColor.mainAppPink())
        SetupComponentDelegetes()
        setupSignUpLabel()
        setupForgotPasswordLabel()
    }
    
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func SignInUser(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        
        ApiManager.sharedInstance.loginClient(email: email, password: password) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.dismiss(animated: true, completion: nil)
            }else{
                self.PresentCustomError(error: msg)
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
        print("backButton Tapped")
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
        guard let _ = passwordTextField.text,  !(passwordTextField.text?.isEmpty)! else {
            self.PresentCustomError(error: "Enter Password!")
            return
        }
        guard let _ = emailTextField.text,  !(emailTextField.text?.isEmpty)!else {
             self.PresentCustomError(error: "Enter your Email!")
            return
        }
        //  SignInUser()
    }
    
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
    func PresentCustomError(error: String){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let button1 = alertView.addButton("Ok"){}
        alertView.showInfo("Error!", subTitle: "\(error)")
        button1.backgroundColor = UIColor.gray
    }
    
    
}
