

import UIKit


class LeftMenuCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(titleLabel)
        addSubview(lineView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        
        lineView.anchor(top: nil, leading: titleLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,size: CGSize(width: 0, height: 0.6))
    }
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Setting"
        titleL.font = UIFont.systemFont(ofSize: 14)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let lineView: UIView = {
        let li = UIView()
        li.backgroundColor = UIColor.darkGray
        return li
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


