

import UIKit

class LoginStartScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        setupConstrains()
        HandleTermslabel()
    }
    
    // MARK :-   Main Methods
/********************************************************************************************/
    @objc func SignInButtonAction(sender: UIButton!) {
        self.navigationController?.pushViewController(SignInController(), animated: true)
    }
    @objc func UserSignUpButtonAction(sender: UIButton!) {
        self.navigationController?.pushViewController(SignUpController(), animated: true)
    }
    func HandleTermslabel(){
        TermsLabel.text = "By signing up you agree to our Terms & Conditions and Privacy Policy"
        let text = (TermsLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        let range2 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        TermsLabel.attributedText = underlineAttriString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        TermsLabel.addGestureRecognizer(tap)
        TermsLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = (TermsLabel.text)!
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if sender.didTapAttributedTextInLabel(label: TermsLabel, inRange: termsRange) {
            if let url = URL(string: "https://www.websitepolicies.com/pies/view/4DqVouJR") {
                UIApplication.shared.open(url, options: [:])
            }
        } else if sender.didTapAttributedTextInLabel(label: TermsLabel, inRange: privacyRange) {
            if let url = URL(string: "https://www.freeprivacypolicy.com/ivacy/view/f62a5df902493617d295ff0c3dfedefb") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            print("Tapped none")
        }
    }
    @objc func backButtonAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupConstrains(){
        [imageView,IconImage,SignInButton,SignUpButton,TermsLabel,welcomeLabel].forEach { view.addSubview($0) }
        
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0),size: CGSize(width: 24, height: 20))
        
        
        IconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 50, height: 50))
        IconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        welcomeLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        
        
        
        SignInButton.anchor(top: nil, leading: view.leadingAnchor, bottom: SignUpButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20),size: CGSize(width: 0, height: 50))
        SignUpButton.anchor(top: nil, leading: view.leadingAnchor, bottom: TermsLabel.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 14, right: 20),size: CGSize(width: 0, height: 50))
        
        TermsLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 10, right: 15))
    }
    
    
    // MARK :-  Setup Component
    /********************************************************************************************/
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
        button.setTitle("Signin", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainColor2()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.mainColor2().cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
        return button
    }()
    let SignUpButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Register", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.mainColor2().cgColor
        button.setTitleColor(UIColor.mainColor2(), for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(UserSignUpButtonAction), for: .touchUpInside)
        return button
    }()
    let TermsLabel: UILabel = {
        let titleL = UILabel()
        titleL.numberOfLines = 0
        titleL.font = UIFont.systemFont(ofSize: 11)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .center
        return titleL
    }()
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.image = UIImage(named: "ige2")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let IconImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "logo1")
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    let welcomeLabel : UILabel = {
        var label = UILabel()
        label.text = "Welcome to Groom & Bride"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
}


