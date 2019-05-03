
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        SVProgressHUD.setForegroundColor(UIColor.darkGray)
        
        setupConstrains()
        SetupComponentDelegetes()
        ShowVisibleButton()
        setupGestureRecognizer()
     
    }
    @objc func AddNewuser(){
        guard let name = NameTextField.text ,let email = EmailTextField.text, let password = PasswordTextField.text  else {
                return
            }
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        ApiManager.sharedInstance.registerNewClient(email: email, name: name, password: password) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                self.dismiss(animated: true, completion: nil)
            }else{
                self.PresentCustomError(error: msg)
            }
        }
    }

    @objc func SignUpButtonAction(sender: UIButton!) {
        view.endEditing(true)
        checkEmptyFields()
    }
    
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func SetupComponentDelegetes(){
        NameTextField.delegate = self
        PasswordTextField.delegate = self
        EmailTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func checkEmptyFields(){
        guard let _ = PasswordTextField.text,  !(PasswordTextField.text?.isEmpty)! else {
             self.PresentCustomError(error: "Enter Password!")
            return
        }
        guard let _ = NameTextField.text,  !(NameTextField.text?.isEmpty)! else {
             self.PresentCustomError(error: "Enter your Name!")
            return
        }
        guard let _ = EmailTextField.text,  !(EmailTextField.text?.isEmpty)!else {
             self.PresentCustomError(error: "Enter your Email!")
            return
        }
        
        AddNewuser()
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
    
    
    //     MARK :- eye button on textfield
    /**********************************************************************************************/
    func ShowVisibleButton(){
        view.addSubview(rightButtonToggle)
        rightButtonToggle.anchor(top: nil, leading: nil, bottom: PasswordTextField.bottomAnchor, trailing: PasswordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 10), size: CGSize(width: 25, height: 25))
    }
    let rightButtonToggle: UIButton = {
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width: 25, height: 25)
        rightButton.setBackgroundImage(UIImage(named: "HidePasswordICON"), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: "ShowPasswordICON"), for: .selected)
        rightButton.isSelected = false
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        rightButton.addTarget(self, action: #selector(PasswordTogglekButtonAction), for: .touchUpInside)
        return rightButton
    }()
    
    var secure = false
    @objc func PasswordTogglekButtonAction(){
        if(secure == false) {
            PasswordTextField.isSecureTextEntry = false
            rightButtonToggle.isSelected = true
        } else {
            PasswordTextField.isSecureTextEntry = true
            rightButtonToggle.isSelected = false
        }
        secure = !secure
    }
    @objc func facebookSignUpButtonAction(_ sender: UITapGestureRecognizer){
        print("facebook sign up")
        
    }
    @objc func googleSignUpButtonAction(_ sender: UITapGestureRecognizer){
        print("google sign up")
        
    }
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = (signUpLabel.text)!
        let termsRange = (text as NSString).range(of: "Sign Up")
        
        if sender.didTapAttributedTextInLabel(label: signUpLabel, inRange: termsRange) {
            print("sign upppppp")
            
        }
        
    }
    
    
    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupConstrains(){
//          view.addSubview(backgroundImageView)
//          backgroundImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0),size: CGSize(width: 24, height: 20))
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 50, height: 50))
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(stackView4)
        stackView4.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20),size: CGSize(width: 0, height: 6*(view.frame.height/8)))
        
        stackView4.addArrangedSubview(scrollView)
        scrollView.anchor(top: stackView4.topAnchor, leading: stackView4.leadingAnchor, bottom: stackView4.bottomAnchor, trailing: stackView4.trailingAnchor)
        
        
        
        
        
          scrollView.addSubview(LogInLabel)
        LogInLabel.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
         LogInLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
         scrollView.addSubview(stackView2)
        stackView2.addArrangedSubview(NameTextField)
        stackView2.addArrangedSubview(EmailTextField)
        stackView2.addArrangedSubview(PasswordTextField)
        stackView2.anchor(top: LogInLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        NameTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor,size: CGSize(width: 0, height: 45))
        EmailTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor,size: CGSize(width: 0, height: 45))
        PasswordTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor, size: CGSize(width: 0, height: 45))
        
//          scrollView.addSubview(forgetPasswordLabel)
//        forgetPasswordLabel.anchor(top: stackView2.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
//        forgetPasswordLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
           scrollView.addSubview(SignUpButton)
         SignUpButton.anchor(top: stackView2.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 45))
        
        
//         scrollView.addSubview(signUpLabel)
//        signUpLabel.anchor(top: SignUpButton.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
      
        
        
//        view.addSubview(stackView10)
//        stackView10.addArrangedSubview(googleImageView)
//        stackView10.addArrangedSubview(facebookImageView)
//        stackView10.anchor(top: nil, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 0), size: CGSize(width: 0, height: 35))
//        stackView10.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//
//        facebookImageView.anchor(top: stackView10.topAnchor, leading: nil, bottom: stackView10.bottomAnchor, trailing: nil, size: CGSize(width: 35, height: 35))
//        googleImageView.anchor(top: stackView10.topAnchor, leading: nil, bottom: stackView10.bottomAnchor, trailing: nil, size: CGSize(width: 35, height: 35))
//
//
//        scrollView.addSubview(orSignUpWithLabel)
//        orSignUpWithLabel.anchor(top: nil, leading: scrollView.leadingAnchor, bottom: stackView10.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 14, right: 0))
//
    }
    
    
    
    // MARK :-  Setup Component
    /********************************************************************************************/
    let stackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.fillEqually
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 5
        return sv
    }()
    let stackView3: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing   = 0.0
        return sv
    }()
    let stackView4: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing  = 30
        return sv
    }()
//    let stackView10: UIStackView = {
//        let sv = UIStackView()
//        sv.axis  = NSLayoutConstraint.Axis.horizontal
//        sv.distribution  = UIStackView.Distribution.fillEqually
//        sv.alignment = UIStackView.Alignment.center
//        sv.spacing = 15.0
//        return sv
//    }()
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor.clear
        v.isScrollEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize.height = 2000
        return v
    }()
    let LogInLabel : UILabel = {
        var label = UILabel()
        label.text = "Register"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    lazy var signUpLabel : UILabel = {
        var label = UILabel()
        label.text = "Not yet a member? Sign UP"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        
        let attributedText = NSMutableAttributedString(string: "Not yet a member?", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]))
        
        label.attributedText = attributedText
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let orSignUpWithLabel : UILabel = {
        var label = UILabel()
        label.text = "or Sign Up with"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    let EmailTextField: SkyFloatingLabelTextField = {
        let tx = SkyFloatingLabelTextField(frame: CGRect(x: 20, y: 100, width: 250, height: 60))
        tx.placeholder = "Email"
        tx.title = "Email"
        tx.lineHeight = 1.0
        tx.selectedLineHeight = 2.0
        tx.tintColor = UIColor.mainColor2() // the color of the blinking cursor
        tx.textColor = UIColor.darkGray
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainBlue()
        tx.font = UIFont(name: "FontAwesome", size: 15)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.emailAddress
        tx.returnKeyType = UIReturnKeyType.done
        tx.clearButtonMode = UITextField.ViewMode.whileEditing;
        tx.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tx.backgroundColor = UIColor.darkGray
//        tx.layer.cornerRadius = 5
        return tx
    }()
    let PasswordTextField: SkyFloatingLabelTextField = {
        let tx = SkyFloatingLabelTextField(frame: CGRect(x: 20, y: 100, width: 250, height: 60))
        tx.placeholder = "Password"
        tx.title = "Password"
        tx.lineHeight = 1.0
        tx.selectedLineHeight = 2.0
        tx.tintColor = UIColor.mainColor2()  // the color of the blinking cursor
        tx.textColor = UIColor.darkGray
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainColor2()
        tx.isSecureTextEntry = true
        tx.font = UIFont(name: "FontAwesome", size: 15)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.default
        tx.returnKeyType = UIReturnKeyType.done
        tx.clearButtonMode = UITextField.ViewMode.never
        tx.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tx
    }()
    let NameTextField: SkyFloatingLabelTextField = {
        let tx = SkyFloatingLabelTextField(frame: CGRect(x: 20, y: 100, width: 250, height: 60))
        tx.placeholder = "Full Name"
        tx.title = "Full Name"
        tx.lineHeight = 1.0
        tx.selectedLineHeight = 2.0
        tx.tintColor = UIColor.mainColor2()  // the color of the blinking cursor
        tx.textColor = UIColor.darkGray
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainColor2()
        tx.font = UIFont(name: "FontAwesome", size: 15)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.default
        tx.returnKeyType = UIReturnKeyType.done
        tx.clearButtonMode = UITextField.ViewMode.whileEditing;
        tx.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tx
    }()
    let backButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("", for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "backButtonIOCN"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    let SignUpButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainColor2()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(SignUpButtonAction), for: .touchUpInside)
        return button
    }()
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.image = UIImage(named: "logo1")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.image = UIImage(named: "unspl66")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
//    lazy var facebookImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.backgroundColor = UIColor.clear
//        iv.image = UIImage(named: "facebook")
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.facebookSignUpButtonAction(_:)))
//        iv.addGestureRecognizer(tapGesture2)
//        iv.isUserInteractionEnabled = true
//        return iv
//    }()
//    lazy var googleImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.backgroundColor = UIColor.clear
//        iv.image = UIImage(named: "google")
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.googleSignUpButtonAction(_:)))
//        iv.addGestureRecognizer(tapGesture2)
//        iv.isUserInteractionEnabled = true
//        return iv
//    }()
    // ***************************
//
//    let CancelButton: UIButton = {
//        let button = UIButton.init(type: .system)
//        button.setTitle("Cancel", for: .normal)
//        // button.frame.size = CGSize(width: 100, height: 40)
//        button.layer.cornerRadius = 5
//        button.backgroundColor = UIColor.white
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.red.cgColor
//        button.setTitleColor(UIColor.red, for: .normal)
//    //    button.addTarget(self, action: #selector(CancelButtonAction), for: .touchUpInside)
//        return button
//    }()
//    let SaveButtonn: UIButton = {
//        let button = UIButton.init(type: .system)
//        button.setTitle("Save", for: .normal)
//        //     button.frame.size = CGSize(width: 100, height: 40)
//        button.layer.cornerRadius = 5
//        button.backgroundColor = UIColor.red
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
//        //button.addTarget(self, action: #selector(SaveButtonAction), for: .touchUpInside)
//        return button
//    }()
}

