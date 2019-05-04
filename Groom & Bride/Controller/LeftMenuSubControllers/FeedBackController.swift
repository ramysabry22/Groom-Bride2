
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import SCLAlertView
import SVProgressHUD

class FeedBackController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        SVProgressHUD.setForegroundColor(UIColor.darkGray)
        setupNavigationBar()
        setupConstrains()
        setupGestureRecognizer()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        navigationController?.isNavigationBarHidden = false
//    }
    
    // MARK :-   Main Methods
    /********************************************************************************************/
    @objc func sendFeddBackButton(){
//        guard let text = textArea.text else {
//            print("form is not valid *****ERROR*****")
//            return
//        }
//        SVProgressHUD.show()
//        SVProgressHUD.setDefaultMaskType(.clear)
//
//        guard let userID = Auth.auth().currentUser?.uid else {
//            self.PresentCustomError(error: "Try again later")
//            self.dismissRingIndecator()
//            return
//        }
//        let ref = Database.database().reference().child("FeedbackMessages").child(userID)
//        let timeCreated: String = String(NSDate().timeIntervalSince1970)
//        let values = ["fromid": userID,"messege": text, "time": timeCreated] as [String : Any]
//        ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
//            if error != nil {
//                print("error uplading image",error ?? "")
//                self.dismissRingIndecator()
//                self.PresentCustomError(error: error?.localizedDescription ?? "Try again later")
//                return
//            }
//            // succeed ..
//            self.dismissRingIndecator()
//            self.PresentCustomSuccess(error: "Message sent successfully")
//
//        })
        
        
    }
    @objc func SendFeedbackButtonTapped(sender: UIButton!) {
        checkEmptyFields()
    }
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
    
    @objc func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    func checkEmptyFields(){
        guard let _ = emailTextfiled.text,  (emailTextfiled.text?.IsValidString())!,
        (emailTextfiled.text?.isValidEmail())! else {
            self.PresentCustomError(error: "Enter valid email in order to contact you!")
            return
        }
        guard let _ = textArea.text, (textArea.text?.IsValidString())!  else {
            self.PresentCustomError(error: "Enter feedback")
            return
        }
        
        sendFeddBackButton()
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
        let button1 = alertView.addButton("OK"){
            self.navigationController?.popViewController(animated: true)
        }
        alertView.showInfo("Done!", subTitle: "\(error)")
        button1.backgroundColor = UIColor.gray
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        
        let firstLabel = UILabel()
        firstLabel.text = "Feedback"
        firstLabel.font = UIFont.systemFont(ofSize: 18)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.black
        navigationItem.titleView = firstLabel
        
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackImage@@@")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //   MARK :- Constrains
/**********************************************************************************************/
    private func setupConstrains(){
           view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 10, right: 15))
        
           scrollView.addSubview(emailLabel)
        emailLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))

          scrollView.addSubview(emailTextfiled)
        emailTextfiled.anchor(top: emailLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5), size: CGSize(width: 0, height: 45))
        emailTextfiled.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        
        
           scrollView.addSubview(feedbackLabel)
        feedbackLabel.anchor(top: emailTextfiled.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))
        
           scrollView.addSubview(textArea)
        let textAreaHeight = min(600, view.frame.height/4)
        textArea.anchor(top: feedbackLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 8, left: 5, bottom: 0, right: 5), size: CGSize(width: 0, height: textAreaHeight))
        textArea.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
           scrollView.addSubview(SendFeedbackButton)
         let maxComponentWidht = min(400, (view.frame.width/3)+20)
        SendFeedbackButton.anchor(top: textArea.bottomAnchor, leading: nil, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 45, left: 0, bottom: 0, right: 10), size: CGSize(width: maxComponentWidht, height: 45))
        
        
    }
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor.white
        v.isScrollEnabled = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize = CGSize(width: 0, height: 2000)
        return v
    }()
    let emailLabel : UILabel = {
        var label = UILabel()
        label.text = "Email address"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        return label
    }()
    let feedbackLabel : UILabel = {
        var label = UILabel()
        label.text = "Tell us more"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        return label
    }()
    lazy var textArea: CustomTextView = {
        let ta = CustomTextView()
        ta.textColor = UIColor.gray
        ta.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        ta.layer.cornerRadius = 5
        ta.delegate = self
        ta.placeholderLabel.text = "Type here"
        ta.returnKeyType = .done
        return ta
    }()
    lazy var emailTextfiled: UITextField = {
        let tx = UITextField()
        tx.placeholder = "Email address"
        tx.tintColor = UIColor.lightGray
        tx.textColor = UIColor.darkGray
        tx.font = UIFont(name: "FontAwesome", size: 14)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.default
        tx.returnKeyType = UIReturnKeyType.done
        tx.clearButtonMode = UITextField.ViewMode.whileEditing
        tx.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tx.delegate = self
        tx.returnKeyType = .done
        tx.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return tx
    }()
    let SendFeedbackButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Send Feedback", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.mainColor2()
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(SendFeedbackButtonTapped), for: .touchUpInside)
        return button
    }()
    
}

