
import UIKit

class NotificationsCustomCell: UICollectionViewCell{
    
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
    
    var titleWidthAnchor: NSLayoutConstraint?
    var subTitleWidthAnchor: NSLayoutConstraint?
    
    func setupViews(){
        addSubview(iconImage)
        addSubview(dateLabel)
        addSubview(stackView2)
        
       iconImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 8, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
        stackView2.addArrangedSubview(titleLabel)
        stackView2.addArrangedSubview(subTitleLabel)
        
        stackView2.anchor(top: topAnchor, leading: iconImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 3, right: 5))
        
        dateLabel.anchor(top: nil, leading: iconImage.trailingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 7, right: 0))
    }
    let stackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.leading
        sv.spacing = 10
        return sv
    }()
    let iconImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "logo1")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.white
        image.layer.cornerRadius = 5
        return image
    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Today is the last day for promo code, try it now!"
        titleL.font = UIFont.boldSystemFont(ofSize: 18)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.white
        return titleL
    }()
    let subTitleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "text text text text text text text text text text"
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.white
        return titleL
    }()
    let dateLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "25 Feb 2019"
        titleL.font = UIFont.systemFont(ofSize: 13)
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

