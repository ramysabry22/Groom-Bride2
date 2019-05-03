

import UIKit

class CustomMoreHeader: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(stackView2)
        addSubview(EditImage)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        stackView2.addArrangedSubview(nameLabel)
        stackView2.addArrangedSubview(emailLabel)
        
        
        stackView2.anchor(top: profileImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        EditImage.anchor(top: nil, leading: nameLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 18, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
        EditImage.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: -6).isActive = true
        
        
    }
    let stackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 2
        return sv
    }()
    let profileImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "ProfileIcon2")?.withRenderingMode(.alwaysTemplate)
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.clear
        image.isUserInteractionEnabled = true
        return image
    }()
    lazy var EditImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "EditProfileICON")?.withRenderingMode(.alwaysTemplate)
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.clear
        image.isUserInteractionEnabled = true
        return image
    }()
    let nameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Ahmed Samir"
        titleL.font = UIFont.boldSystemFont(ofSize: 15)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let emailLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "ahmedsamir22@gmail.com"
        titleL.font = UIFont.boldSystemFont(ofSize: 12)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

