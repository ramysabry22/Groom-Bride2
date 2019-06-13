

import UIKit

class LeftMenuHeader: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStackview)
        
        mainStackview.addArrangedSubview(SignInButton)
        mainStackview.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        mainStackview.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0).isActive = true
        
        
        SignInButton.anchor(top: nil, leading: mainStackview.leadingAnchor, bottom: nil, trailing: mainStackview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    let mainStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 2
        return sv
    }()
    let SignInButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Log in / Create account", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


