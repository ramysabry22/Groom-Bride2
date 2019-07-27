
import UIKit
import SVProgressHUD
import SCLAlertView
import Instructions


extension FavoritesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allHalls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteHallCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "FavoriteHallCell", for: indexPath) as! FavoriteHallCell
        
        let rowHall = allHalls[indexPath.row]
        cell.favoriteHall = rowHall
        cell.tag = indexPath.row
        cell.delegete = self
        if rowHall.hallId.hallImage.count > 0 && rowHall.hallId.hallImage.isEmpty == false {
            let tempImageView : UIImageView! = UIImageView()
            let url = URL(string: "\(rowHall.hallId.hallImage[0])")
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
        cell.makeShadow(cornerRadius: 8)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = max(270, view.frame.height/3)
        return CGSize(width: view.frame.width-22, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHall = allHalls[indexPath.row]
        if selectedHall.hallId.hallImage.isEmpty == true || selectedHall.hallId.hallImage.count <= 0 {
            self.show1buttonAlert(title: "Oops", message: "Sorry, hall info not available, contact us to report issue", buttonTitle: "OK") {
                
            }
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
        controller.favoriteDetailedHall = allHalls[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        let offsetY = scrollView.contentOffset.y + 700
        //        let contentHeight = scrollView.contentSize.height
        //
        //        if offsetY > contentHeight - scrollView.frame.size.height{
        //            if isFinishedPaging == true {
        //                pagesNumber += 1
        //                self.fetchFavoriteHalls(limit: 5, offset: pagesNumber)
        //            }
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if ((indexPaths.last?.row)! + 4) > self.allHalls.count && isFinishedPaging == true {
            pagesNumber += 1
            self.fetchFavoriteHalls(limit: 7, offset: pagesNumber)
        }
    }
    
    
}
