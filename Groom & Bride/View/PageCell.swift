
import UIKit

class PageCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var page: Page? {
        didSet{
            guard let page = page else{
                return
            }
            imageView.image = UIImage(named: page.imageName)
            titleLabel.text = "\(page.title)"
            subTitleLabel.text = "\(page.message)"
        }
        
    }
}
