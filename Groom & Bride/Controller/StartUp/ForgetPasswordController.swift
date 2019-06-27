
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import SCLAlertView
import SVProgressHUD
import Alamofire

class ForgetPasswordController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setupView()
        SetupComponentDelegetes()
    }
    
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func sendResetPassword(){
        guard let email = emailTextField.text else {
            return
        }
        SVProgressHUD.show()
        ApiManager.sharedInstance.forgotPassword(email: email) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.show1buttonAlert(title: "Email sent successfully", message: msg, buttonTitle: "OK") {
                  //  self.navigationController?.popViewController(animated: true)
                }
            }else {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK") {
                }
            }
        }
        
    }
    @IBAction func SendButtonAction(_ sender: UIButton) {
       view.endEditing(true)
       checkEmptyFields()
    }
    @IBAction func BackButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    func SetupComponentDelegetes(){
        emailTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func checkEmptyFields(){
        guard let _ = emailTextField.text,  !(emailTextField.text?.isEmpty)! , emailTextField.text?.isValidEmail() ?? false  else {
            self.show1buttonAlert(title: "Error", message: "Not valid email!", buttonTitle: "OK") {
            }
            return
        }
        sendResetPassword()
    }
   
    
}

