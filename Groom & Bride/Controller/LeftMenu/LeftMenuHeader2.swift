

import UIKit

class LeftMenuHeader2: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainStackview)
        mainStackview.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: frame.width/10, bottom: 0, right: frame.width/14))
        mainStackview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        mainStackview.addArrangedSubview(labelsStackview)
    
        labelsStackview.addArrangedSubview(nameLabel)
        labelsStackview.addArrangedSubview(emailLabel)
        labelsStackview.anchor(top: nil, leading: mainStackview.leadingAnchor, bottom: nil, trailing: mainStackview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        nameLabel.anchor(top: nil, leading: labelsStackview.leadingAnchor, bottom: nil, trailing: nil)
        emailLabel.anchor(top: nil, leading: labelsStackview.leadingAnchor, bottom: nil, trailing: nil)
        
        
        mainStackview.addArrangedSubview(editButton)
        editButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 25, height: 25))
    }
    let mainStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 2
        return sv
    }()
    let labelsStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 2
        return sv
    }()
    let editButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(named: "SettingICON@@@")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        button.tintColor = UIColor.white.withAlphaComponent(0.7)
        return button
    }()
    let nameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "User Name"
        titleL.font = UIFont.boldSystemFont(ofSize: 21)
        titleL.textColor = UIColor.white
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let emailLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Email"
        titleL.font = UIFont.systemFont(ofSize: 12)
        titleL.textColor = UIColor.white
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


