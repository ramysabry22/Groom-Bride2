
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import SCLAlertView
import SVProgressHUD

class EditProfileController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupConstrains()
        
        fetchUserInfo()
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
    }
    
// MARK :-   Main Methods
/********************************************************************************************/
    private func fetchUserInfo(){
        NameTextField.text = "Ahmed Samir"
        EmailTextField.text = "ahmedsamir22@gmail.com"
        PasswordTextField.text = "123123"
    }
    @objc func SignUpButtonAction(sender: UIButton!) {
       // ********
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
    @objc func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
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
//   MARK :- Constrains
/**********************************************************************************************/
     let firstLabel = UILabel()
    private func setupConstrains(){
       
        firstLabel.text = "Edit Profile"
        firstLabel.font = UIFont.boldSystemFont(ofSize: 19)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.gray
        view.addSubview(firstLabel)
        firstLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 44))
        
        view.addSubview(backButton)
        backButton.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0),size: CGSize(width: 24, height: 20))
        backButton.centerYAnchor.constraint(equalTo: firstLabel.centerYAnchor).isActive = true
        
      
//        view.addSubview(profileImage)
//         profileImage.anchor(top: firstLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
        
        view.addSubview(stackView4)
        stackView4.anchor(top: firstLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 10, right: 20),size: CGSize(width: 0, height: 6*(view.frame.height/8)))
        
        stackView4.addArrangedSubview(scrollView)
        scrollView.anchor(top: stackView4.topAnchor, leading: stackView4.leadingAnchor, bottom: stackView4.bottomAnchor, trailing: stackView4.trailingAnchor)
        
        
        scrollView.addSubview(profileImage)
        profileImage.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
         profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        scrollView.addSubview(stackView2)
        stackView2.addArrangedSubview(NameTextField)
        stackView2.addArrangedSubview(EmailTextField)
        stackView2.addArrangedSubview(PasswordTextField)
        stackView2.anchor(top: profileImage.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        NameTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor,size: CGSize(width: 0, height: 45))
        EmailTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor,size: CGSize(width: 0, height: 45))
        PasswordTextField.anchor(top: nil, leading: stackView2.leadingAnchor, bottom: nil, trailing: stackView2.trailingAnchor, size: CGSize(width: 0, height: 45))
        
        PasswordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        //          scrollView.addSubview(forgetPasswordLabel)
        //        forgetPasswordLabel.anchor(top: stackView2.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        //        forgetPasswordLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(SignUpButton)
        SignUpButton.anchor(top: stackView2.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 45))
        
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
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor.clear
        v.isScrollEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize.height = 2000
        return v
    }()
    let EmailTextField: SkyFloatingLabelTextField = {
        let tx = SkyFloatingLabelTextField(frame: CGRect(x: 20, y: 100, width: 250, height: 60))
        tx.placeholder = "Email"
        tx.title = "Email"
        tx.lineHeight = 1.0
        tx.selectedLineHeight = 2.0
        tx.tintColor = UIColor.mainColor2() // the color of the blinking cursor
        tx.textColor = UIColor.black
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainBlue()
        tx.font = UIFont(name: "FontAwesome", size: 13)
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
        tx.textColor = UIColor.black
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainBlue()
        tx.isSecureTextEntry = true
        tx.font = UIFont(name: "FontAwesome", size: 13)
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
        tx.textColor = UIColor.black
        tx.lineColor = UIColor.lightGray
        tx.selectedTitleColor = UIColor.gray
        tx.selectedLineColor = UIColor.mainBlue()
        tx.font = UIFont(name: "FontAwesome", size: 13)
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
        button.setTitle("Update profile", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainColor2()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(SignUpButtonAction), for: .touchUpInside)
        return button
    }()
    let profileImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "ProfileIcon2")?.withRenderingMode(.alwaysTemplate)
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.lightGray
        image.backgroundColor = UIColor.clear
        return image
    }()


}
