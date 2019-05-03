
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import SCLAlertView
import SVProgressHUD


class ForgetPasswordController: UIViewController,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        SVProgressHUD.setForegroundColor(UIColor.darkGray)
        
        setupConstrains()
        SetupComponentDelegetes()
        setupGestureRecognizer()
    }
    
    
    // MARK :-   Main Methods
    /********************************************************************************************/
    @objc func sendResetPassword(){
        guard let email = EmailTextField.text else {
            print("form is not valid *****ERROR*****")
            return
        }
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error as Any)
                let showError:String = error?.localizedDescription ?? ""
                self.dismissRingIndecator()
                self.PresentCustomError(error: showError)
                return
            }
            // suceess
            self.dismissRingIndecator()
           self.PresentCustomSuccess(error: "Reset password link sent correctly, check your email and login again")
        }
        
    }
    @objc func SignInButtonAction(sender: UIButton!) {
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
        guard let _ = EmailTextField.text,  !(EmailTextField.text?.isEmpty)!else {
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

    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupConstrains(){
      
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
        
        
        scrollView.addSubview(subTitleLabel)
        subTitleLabel.anchor(top: LogInLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
         subTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        scrollView.addSubview(stackView2)
        stackView2.addArrangedSubview(EmailTextField)
    
        stackView2.anchor(top: subTitleLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 22, left: 0, bottom: 0, right: 0))
        EmailTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor,size: CGSize(width: 0, height: 45))
       
   
        scrollView.addSubview(SignInButton)
        SignInButton.anchor(top: stackView2.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 45))
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
    let stackView4: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing  = 30
        return sv
    }()

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
        label.text = "Forget your password?"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    let subTitleLabel : UILabel = {
        var label = UILabel()
        label.text = "Enter your email you are using for your account and we will send you password reset link"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    let EmailTextField: SkyFloatingLabelTextField = {
        let tx = SkyFloatingLabelTextField(frame: CGRect(x: 20, y: 100, width: 250, height: 60))
        tx.placeholder = "Type your email"
        tx.title = "Email"
        tx.lineHeight = 1.0
        tx.selectedLineHeight = 2.0
        tx.tintColor = UIColor.mainColor2() // the color of the blinking cursor
        tx.textColor = UIColor.black
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainBlue()
        tx.font = UIFont(name: "FontAwesome", size: 15)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.emailAddress
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
    let SignInButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Reset", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainColor2()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
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

    
}

