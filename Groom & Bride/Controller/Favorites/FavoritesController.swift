
import UIKit
import SVProgressHUD
import SCLAlertView
import Instructions

class FavoritesController: UIViewController, removeFromFavoriteProtocol{
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    let coachMarksController = CoachMarksController()
    var allHalls: [FavoriteHall] = []
    var isFinishedPaging = true
    var pagesNumber: Int = 0
    lazy var objCell = collectionView1.cellForItem(at: IndexPath(item: 0, section: 0)) as! FavoriteHallCell

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupComponents()
        SVProgressHUD.setupView()
        SVProgressHUD.show()
        fetchFavoriteHalls(limit: 7, offset: 0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if firstOpenDone() == false {
           self.coachMarksController.stop(immediately: true)
        }
    }
    
    
    // MARK:- Favorite fetching functions
/*****************************************************************************************/
    func fetchFavoriteHalls(limit: Int, offset: Int){
        isFinishedPaging = false
        ApiManager.listFavoriteHalls(limit: limit, offset: offset) { (valid, msg, reRequest, halls) in
            self.dismissRingIndecator()
            self.isFinishedPaging = true
            if reRequest {
                self.fetchFavoriteHalls(limit: limit, offset: offset)
            }
            else if valid {
                if halls.count > 0 {
                    for record in halls {
                        self.allHalls.append(record)
                    }
                    self.collectionView1.reloadData()
                    if self.firstOpenDone() == false {
                        self.coachMarksController.start(in: .window(over: self))
                        self.finishCoachMark()
                    }
                }
                
                if self.allHalls.count > 0 {
                    self.emptyLabel.isHidden = true
                }else{
                    self.emptyLabel.isHidden = false
                }
            }
            else if !valid {
                self.show1buttonAlert(title: "Error", message: "Unexpected Error Please Try Again In A While", buttonTitle: "OK", callback: {
                })
            }
            
        }
    }
    
    func removeFromFavoriteButton(_ sender: FavoriteHallCell) {
        guard let indexPath = collectionView1.indexPath(for: sender) else { return }
        SVProgressHUD.show()
        ApiManager.deleteHallFromFavorite(hallID: (sender.favoriteHall?.hallId._id)!) { (valid, msg, reRequest) in
            self.dismissRingIndecator()
            if reRequest {
                self.removeFromFavoriteButton(sender)
            }
            else if valid {
                self.allHalls.remove(at: indexPath.row)
                self.collectionView1.deleteItems(at: [indexPath])
                self.collectionView1.reloadData()
                
                if self.allHalls.count > 0 {
                    self.emptyLabel.isHidden = true
                }else{
                    self.emptyLabel.isHidden = false
                }
            }
            else if !valid {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    func setupComponents(){
        self.collectionView1.register(UINib(nibName: "FavoriteHallCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteHallCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.prefetchDataSource = self
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.color = UIColor.black.withAlphaComponent(0.6)
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
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
   
    
}
