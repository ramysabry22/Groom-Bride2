

import UIKit

class LeftMenuHeader2: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -frame.height/6).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
     
        addSubview(stackview)
        stackview.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: frame.height/6, right: 10))
        
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(emailLabel)
        
        nameLabel.anchor(top: nil, leading: stackview.leadingAnchor, bottom: nil, trailing: stackview.trailingAnchor)
        emailLabel.anchor(top: nil, leading: stackview.leadingAnchor, bottom: nil, trailing: stackview.trailingAnchor)
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
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 7
        return sv
    }()
    let nameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Name Name Name"
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        titleL.textColor = UIColor.mainAppPink()
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let emailLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Email@Email.com"
        titleL.font = UIFont.systemFont(ofSize: 13)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


