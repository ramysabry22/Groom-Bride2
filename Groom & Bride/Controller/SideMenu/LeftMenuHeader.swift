

import UIKit

class LeftMenuHeader: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -frame.height/6).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        addSubview(stackview)
        stackview.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 10), size: CGSize(width: 0, height: 45))
        
        stackview.addArrangedSubview(loginButton)
        stackview.addArrangedSubview(registerButton)
        
        let buttonWidth = (frame.width-35)/2
        loginButton.anchor(top: stackview.topAnchor, leading: nil, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: buttonWidth, height: 45))
        registerButton.anchor(top: stackview.topAnchor, leading: nil, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: buttonWidth, height: 45))
        
        addSubview(view1)
        view1.anchor(top: stackview.topAnchor, leading: loginButton.trailingAnchor, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 7, bottom: 5, right: 0),size: CGSize(width: 2, height: 45))
        
        addSubview(view2)
        view2.anchor(top: nil, leading: leadingAnchor, bottom: stackview.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 2))
        
        addSubview(view3)
        view3.anchor(top: stackview.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 5))
    }
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo2")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let stackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.distribution  = UIStackView.Distribution.fill
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 15
        return sv
    }()
    let loginButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    let registerButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    let view1: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.mainAppPink()
        return iv
    }()
    let view2: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#F3EAEA")
        return iv
    }()
    let view3: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#F3EAEA")
        return iv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


