

import UIKit
import SVProgressHUD
import Alamofire

class MyProfileController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        loadUserData()
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    

    func saveNewInfo(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        SVProgressHUD.show()
        let name = NameTextField.text
        ApiManager.sharedInstance.updateName(name: name!) { (valid, msg, reRequest) in
            self.dismissRingIndecator()
            if reRequest {
                self.saveNewInfo()
            }
            else if valid {
                HelperData.sharedInstance.loggedInClient.userName = name!
                HelperData.sharedInstance.loggedInClient.login()
                self.show1buttonAlert(title: "Changes saved", message: "Changes saved successfully", buttonTitle: "OK", callback: {
                })
            }else if !valid {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {
                })
            }
            
        }
    }
    
    @IBAction func ApplyChangesButton(_ sender: UIButton) {
        guard let _ = NameTextField.text,  !(NameTextField.text?.isEmpty)! , NameTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter your name!", buttonTitle: "OK") {
            }
            return
        }
        saveNewInfo()
    }
    func loadUserData(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            NameTextField.text = HelperData.sharedInstance.loggedInClient.userName
            EmailTextField.text = HelperData.sharedInstance.loggedInClient.userEmail
            PasswordTextField.text = "*******"
        }
    }
    @IBAction func ChangePasswordButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordController
        navigationController?.pushViewController(controller, animated: true)
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
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
}
