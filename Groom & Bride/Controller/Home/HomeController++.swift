
import UIKit
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher
import SideMenu
import DropDown

extension HomeController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView2 { return allHalls.count }
        else { return hallCategories.count }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView2 {
            let cell: HallCell = collectionView2.dequeueReusableCell(withReuseIdentifier: "HallCell", for: indexPath) as! HallCell
            
            let rowHall = allHalls[indexPath.row]
            cell.hall = rowHall
            cell.tag = indexPath.row
            if rowHall.hallImage.count > 0 && rowHall.hallImage.isEmpty == false {
                let tempImageView : UIImageView! = UIImageView()
                let url = URL(string: "\(rowHall.hallImage[0])")
                tempImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                    if(cell.tag == indexPath.row){
                        if result.isSuccess == false{
                            cell.imageView.image = UIImage(named: "logo1")
                        }else{
                            cell.imageView.image = tempImageView.image
                        }
                    }
                }
            }
            cell.makeShadow(cornerRadius: 8)
            return cell
        }else {
            let cell: FilterCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            
            
            cell.titleLabel.text = hallCategories[indexPath.row][1]
            let imageName = hallCategories[indexPath.row][2]
            cell.imageView.image = UIImage(named: "\(imageName)")?.withRenderingMode(.alwaysTemplate)
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView2 {
            let cellHeight = max(270, view.frame.height/3)
            return CGSize(width: view.frame.width-22, height: cellHeight)
        }else {
             let cellTitle = hallCategories[indexPath.row][1]
             let cellWidth = estimateFrameForSubTitleText(cellTitle).width + 15 + view.frame.width/8
             return CGSize(width: cellWidth, height: collectionView1.frame.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
         if collectionView == collectionView2 { return 20 }
         else { return 0 }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView1 {
            fetchHalls(index: indexPath.row)
        }
       else if collectionView == collectionView2 {
            let selectedHall = allHalls[indexPath.row]
            if selectedHall.hallImage.isEmpty == true || selectedHall.hallImage.count <= 0 {
                self.show1buttonAlert(title: "Oops", message: "Sorry, hall info not available, contact us to report issue", buttonTitle: "OK") {
                    
                }
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
            controller.detailedHall = allHalls[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
   
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let window = UIApplication.shared.keyWindow else { return }

        if velocity.y > 0 && notScrolling { // hide
            notScrolling = false
            isNavBarHidden = true
            self.collectionView2TopConstraint.constant = 50 //
            self.collectionView1TopConstraint.constant = 5
            self.topViewTopConstraint.constant = -110 - window.safeAreaInsets.top
            
            UIView.animate(withDuration: 0.15, animations: {
                 self.navigationController?.setNavigationBarHidden(true, animated: true)
                 self.view.layoutIfNeeded()
            }, completion: { (finished) in
                self.notScrolling = true
            })
        }
        else if velocity.y < 0.0  && notScrolling { // show
             notScrolling = false
             isNavBarHidden = false
             self.collectionView2TopConstraint.constant = 153
             self.collectionView1TopConstraint.constant = 104
             self.topViewTopConstraint.constant = 5
            
            UIView.animate(withDuration: 0.2, animations: {
                 self.navigationController?.setNavigationBarHidden(false, animated: true)
                 self.view.layoutIfNeeded()
            }, completion: { (finished) in
                self.notScrolling = true
            })
        }
        else {
      
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if collectionView == collectionView2 {
            if ((indexPaths.last?.row)! + 5) > self.allHalls.count && isFinishedPaging == true {
                pagesNumber += 1
                if currentCategoryIndex == 0 {
                    self.fetchNewHalls(limit: 7, offset: pagesNumber)
                }else {
                    fetchHallWithCategory(index: currentCategoryIndex, limit: 7, offset: pagesNumber)
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y + 700
//        let contentHeight = scrollView.contentSize.height
        
//        if offsetY > contentHeight - scrollView.frame.size.height{
//            if isFinishedPaging == true {
//               pagesNumber += 1
//                if currentCategoryIndex == 0 {
//                    self.fetchNewHalls(limit: 5, offset: pagesNumber)
//                }else {
//                    fetchHallWithCategory(index: currentCategoryIndex, limit: 5, offset: pagesNumber)
//                }
//            }
//        }
    }
    
    
    
    // MARK : Helping functions
/***********************************************************************/
    fileprivate func estimateFrameForSubTitleText(_ text: String) -> CGRect {
        let size = CGSize(width: 1000, height: 40)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 15)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
    
}
