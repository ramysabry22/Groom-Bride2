import UIKit

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchHallResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HallCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "HallCell", for: indexPath) as! HallCell
        
        let rowHall = searchHallResult[indexPath.row]
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
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = max(270, view.frame.height/3)
        return CGSize(width: view.frame.width-22, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if ((indexPaths.last?.row)! + 4) > self.searchHallResult.count && isFinishedPaging == true {
            self.presenter.pagesNumber += 1
            self.isFinishedPaging = false
            self.presenter.paginate(searchText: SearchText)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTextField.endEditing(true)
        let selectedHall = searchHallResult[indexPath.row]
        if selectedHall.hallImage.isEmpty == true || selectedHall.hallImage.count <= 0 {
            self.show1buttonAlert(title: "Oops", message: "Sorry, hall info not available, contact us to report issue", buttonTitle: "OK") {
                
            }
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
        controller.detailedHall = searchHallResult[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
