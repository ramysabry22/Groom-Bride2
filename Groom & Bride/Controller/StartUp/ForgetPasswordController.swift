
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
        SVProgressHUD.setForegroundColor(UIColor.mainAppPink())
        SetupComponentDelegetes()
    }
    
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func sendResetPassword(){
        guard let email = emailTextField.text else {
            return
        }
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        ApiManager.sharedInstance.forgotPassword(email: email) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.show1buttonAlert(title: "Email sent successfully", message: msg, buttonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
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
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
   

    
}

