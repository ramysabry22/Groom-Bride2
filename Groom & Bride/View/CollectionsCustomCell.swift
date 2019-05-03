
import UIKit

class CollectionsCustomCell: UICollectionViewCell{
    
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
        addSubview(titleLabel)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    let backgroundImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "MaintenanceICON")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.red
        image.layer.cornerRadius = 1
        return image
    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Setting"
        titleL.font = UIFont.boldSystemFont(ofSize: 18)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.green
        return titleL
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

