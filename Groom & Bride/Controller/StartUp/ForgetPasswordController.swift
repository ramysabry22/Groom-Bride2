
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
                self.PresentCustomSuccess(error: msg)
            }else {
                self.PresentCustomError(error: msg)
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
        guard let _ = emailTextField.text,  !(emailTextField.text?.isEmpty)!else {
            self.PresentCustomError(error: "Enter your Email!")
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
    func PresentCustomSuccess(error: String){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let button1 = alertView.addButton("Ok"){
            self.navigationController?.popViewController(animated: true)
        }
        alertView.showInfo("Done!", subTitle: "\(error)")
        button1.backgroundColor = UIColor.gray
    }

    
}

