
import UIKit


class HomeCustomCell: UICollectionViewCell{
    override var isHighlighted: Bool {
        didSet{
            if isHighlighted {
                dummyView.alpha = 0
            }else{
                dummyView.alpha = 1
            }
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(imageView)
         imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        addSubview(dummyView)
        dummyView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
        
        addSubview(titlesStackView)
        titlesStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 10, right: 10), size: CGSize(width: 0, height: 0))
        
        titlesStackView.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: titlesStackView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titlesStackView.rightAnchor).isActive = true
        
        titlesStackView.addArrangedSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leftAnchor.constraint(equalTo: titlesStackView.leftAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: titlesStackView.rightAnchor).isActive = true
    }
    let nameLabel : UILabel = {
        var label = UILabel()
        label.text = "ka3a"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    let priceLabel : UILabel = {
        var label = UILabel()
        label.text = "1500"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    let titlesStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.fillEqually
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 0
        return sv
    }()
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    let dummyView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HomeFilterCustomCell: UICollectionViewCell{
    override var isSelected: Bool {
        didSet{
            if isSelected {
                titleLabel.textColor = UIColor.red
                titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
            }else{
                titleLabel.textColor = UIColor.black
                titleLabel.font = UIFont.systemFont(ofSize: 14)
            }
        }
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 2, left: 2, bottom: 2, right: 2))
    
    }
    let titleLabel : UILabel = {
        var label = UILabel()
        label.text = "ka3a"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
