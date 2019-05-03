

import UIKit

class FavoriteCustomCell: UICollectionViewCell{
    
    override var isHighlighted: Bool {
        didSet{
            if isHighlighted {
                ///  backgroundColor = UIColor.lightGray
            }else{
                /// backgroundColor = UIColor.white
            }
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        addSubview(backgroundImage)
        addSubview(stackView2)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        
        
        stackView2.addArrangedSubview(titleLabel)
        stackView2.addArrangedSubview(subTitleLabel)
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        stackView2.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 15).isActive = true
       // stackView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView2.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        
    }
    let stackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 10
        return sv
    }()
    let backgroundImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "MaintenanceICON")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.red
        image.layer.cornerRadius = 5
        return image
    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "nady 7arer"
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.white
        return titleL
    }()
    let subTitleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "ka3t lo2lo2a"
        titleL.font = UIFont.boldSystemFont(ofSize: 11)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.white
        return titleL
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

