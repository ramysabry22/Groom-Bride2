import UIKit
import SVProgressHUD
import Alamofire

class FeedbackController2: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var textViewPlaceHolderLabel: UILabel!
    @IBOutlet weak var textView1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        EmailTextField.delegate = self
        textView1.delegate = self
        textView1.layer.borderWidth = 1
        textView1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        textView1.layer.cornerRadius = 6
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    
    
    func sendFeedback(email: String, feedbackString: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.sendFeedBack(email: email, feedback: feedbackString) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.show1buttonAlert(title: "Done", message: "Feedback sent successfully", buttonTitle: "OK", callback: {
                })
            }else {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    
    @IBAction func FeedbackButtonAction(_ sender: UIButton) {
        guard let email = EmailTextField.text,  !(EmailTextField.text?.isEmpty)! , EmailTextField.text?.isValidEmail() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Not valid email!", buttonTitle: "OK") {
            }
            return
        }
        guard let feedback = textView1.text,  !(textView1.text?.isEmpty)! , textView1.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error", message: "Enter message!", buttonTitle: "OK") {
            }
            return
        }
        
        sendFeedback(email: email, feedbackString: feedback)
    }
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceHolderLabel.isHidden = !textView1.text.isEmpty
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
      
        navigationItem.title = "Feedback"
        
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
