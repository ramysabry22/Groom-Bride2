

import UIKit


class CustomMoreCell: UICollectionViewCell{
    
    override var isHighlighted: Bool {
        didSet{
            if isHighlighted {
                backgroundColor = UIColor.lightGray
            }else{
                backgroundColor = UIColor.white
            }
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    

    func setupViews(){
        addSubview(Image)
        addSubview(titleLabel)
      //  addSubview(viewMoreImage)
        addSubview(lineView)
        
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        Image.widthAnchor.constraint(equalToConstant: frame.height/3).isActive = true
        Image.heightAnchor.constraint(equalToConstant: frame.height/3).isActive = true
        Image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
//        viewMoreImage.translatesAutoresizingMaskIntoConstraints = false
//        viewMoreImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
//        viewMoreImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        viewMoreImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        viewMoreImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: Image.rightAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
  
        lineView.anchor(top: nil, leading: titleLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 2))
        
    }
    
    let Image : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "MaintenanceICON")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.clear
        return image
    }()
//    let viewMoreImage : UIImageView = {
//        var image = UIImageView()
//        image.image = UIImage(named: "ViewMoreICON")
//        image.layer.masksToBounds = true
//        image.contentMode = .scaleAspectFit
//        image.backgroundColor = UIColor.yellow
//        return image
//    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Setting"
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let lineView: UIView = {
        let li = UIView()
        li.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        return li
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

