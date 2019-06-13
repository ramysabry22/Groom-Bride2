

import UIKit


class LeftMenuCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/16).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: frame.width/18).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,size: CGSize(width: 0, height: 0.6))
    }
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo1")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.white
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Label"
        titleL.font = UIFont.systemFont(ofSize: 15)
        titleL.textColor = UIColor.white
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let lineView: UIView = {
        let li = UIView()
        li.backgroundColor = UIColor(hexString: "#EE5467")
        return li
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


