
import UIKit
import SVProgressHUD

class FavoritesController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    var allHalls: [Hall] = []
    var isFinishedPaging = true
    var pagesNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        self.collectionView1.register(UINib(nibName: "FavoriteHallCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteHallCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        SVProgressHUD.show()
        fetchFavoriteHalls(limit: 5, offdet: 0)
    }
    
    
    func fetchFavoriteHalls(limit: Int, offdet: Int){
        isFinishedPaging = false
        ApiManager.sharedInstance.listFavoriteHalls(limit: limit, offset: offdet) { (valid, msg, reRequest, halls) in
            self.dismissRingIndecator()
            self.isFinishedPaging = true
            if reRequest {
                self.fetchFavoriteHalls(limit: limit, offdet: offdet)
            }
            else if valid {
                if halls.count > 0 {
                    for record in halls {
                        self.allHalls.append(record)
                    }
                    self.collectionView1.reloadData()
                }
            }
            
            
            if self.allHalls.count <= 0 {
                 self.emptyLabel.isHidden = false
            }
        }
    }
    
    
    
    // MARK:- CollectionView
/*********************************************************************************/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allHalls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteHallCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "FavoriteHallCell", for: indexPath) as! FavoriteHallCell
        
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = max(270, view.frame.height/3)
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
        controller.detailedHall = allHalls[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + 700
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height{
            if isFinishedPaging == true {
                pagesNumber += 1
                self.fetchFavoriteHalls(limit: 5, offdet: pagesNumber)
            }
        }
    }
    
    
    
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "logo2")
        iconImage.contentMode = .scaleAspectFit
        iconImage.backgroundColor = UIColor.clear
        navigationItem.titleView = iconImage
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON77777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.mainAppPink()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
    
}
