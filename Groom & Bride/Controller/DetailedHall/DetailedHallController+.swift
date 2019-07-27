import UIKit
import SVProgressHUD
import Cosmos
import Instructions

extension DetailedHallController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hallImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailedHallCustomCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "DetailedHallCustomCell", for: indexPath) as! DetailedHallCustomCell
        
        cell.tag = indexPath.row
        cell.imageView.image = UIImage(named: "AppLogoImage")
        if hallImages.count > 0 && hallImages.isEmpty == false {
            let tempImageView : UIImageView! = UIImageView()
            let rowImage = hallImages[indexPath.row]
            let url = URL(string: "\(rowImage)")
            tempImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                if(cell.tag == indexPath.row){
                    if result.isSuccess == false{
                        cell.imageView.image = UIImage(named: "AppLogoImage")
                    }else{
                        cell.imageView.image = tempImageView.image
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView1.frame.width, height: collectionView1.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        self.pageControl.currentPage = pageNumber
        self.pageControl.updateCurrentPageDisplay()
    }
    
    
}
