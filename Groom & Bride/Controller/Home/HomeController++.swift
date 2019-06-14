
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
        if collectionView == collectionView2 { return 10 }
        else { return filterItems.count }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView2 {
            let cell: HallCell = collectionView2.dequeueReusableCell(withReuseIdentifier: "HallCell", for: indexPath) as! HallCell
            
            cell.backgroundColor = UIColor.white
            return cell
        }else {
            let cell: FilterCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            
            cell.titleLabel.text = filterItems[indexPath.row]
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView2 {
            
            let cellHeight = max(270, view.frame.height/3)
            return CGSize(width: view.frame.width, height: cellHeight)
        }else {
            
             let cellWidth = estimateFrameForSubTitleText(filterItems[indexPath.row]).width + 70
             return CGSize(width: cellWidth, height: 45)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
         if collectionView == collectionView2 { return 13 }
         else { return 200 }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
        navigationController?.pushViewController(controller, animated: true)
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
