
import UIKit
import Alamofire
import SVProgressHUD
import Kingfisher
import SideMenu
import Firebase
import SCLAlertView

class HomeController: UIViewController, UIGestureRecognizerDelegate ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDataSourcePrefetching {
    
    @IBOutlet weak var collectionView1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchIconImage: UIImageView!
    @IBOutlet weak var HomeLabel: UILabel!
    @IBOutlet weak var topComponentView: UIView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    
    let leftMenu1 = LeftMenuController()
    lazy var menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenu1)
    let leftMenu2 = LeftMenuController2()
    lazy var menuLeftNavigationController2 = UISideMenuNavigationController(rootViewController: leftMenu2)
    
    var allHalls: [Hall] = []
    let hallCategories: [[String]] = [["0","All","AllICON777.png"],
                                      ["5d0cbfc9a758321414bf9871","Hotel","HotelICON777"],
                                      ["5d0cbfc9a758321414bf9872","Club","ClubICON777"],
                                      ["5d0cbfc9a758321414bf9873","Yacht","YachtICON777"],
                                      ["5d0cbfc9a758321414bf9874","Villa","VillaICON777"],
                                      ["5d1214f4de675f000488d442","Individual","IndividualICON777"]]
    
    
    var currentCategoryIndex: Int = 0
    var firstOpen = true
    var isFinishedPaging = true
    var pagesNumber: Int = 0
    var notScrolling: Bool = true
    var isNavBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupFirstFilter()
        SVProgressHUD.setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        if firstOpen {
            setupLeftMenuDelegetes()
            setupNavigationBar()
            firstOpen = false
        }
       setupLeftMenu()
        
        if isNavBarHidden == false {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    // MARK :- Fetch Halls
/********************************************************************************************/
    func fetchNewHalls(limit: Int, offset: Int){
        self.isFinishedPaging = false
        ApiManager.sharedInstance.listHalls(limit: limit, offset: offset) { (valid, msg, halls) in
            self.dismissRingIndecator()
            if valid{
               if halls.count > 0 {
                 for record in halls {
                    self.allHalls.append(record)
                 }
                 self.collectionView2.reloadData()
               }
            }else{
               
            }
            self.isFinishedPaging = true
        }
    }
    
    
    func fetchHalls(index: Int){
        if index != currentCategoryIndex {
            SVProgressHUD.show()
            currentCategoryIndex = index
            pagesNumber = 0
            self.allHalls.removeAll()
            self.collectionView2.reloadData()
            if index == 0 {
                fetchNewHalls(limit: 5, offset: 0)
            }else {
                fetchHallWithCategory(index: index, limit: 5, offset: 0)
            }
        }
    }
    
    
    func fetchHallWithCategory(index: Int, limit: Int, offset: Int){
        isFinishedPaging = false
        let hallID = hallCategories[index][0]
        ApiManager.sharedInstance.listHallsByCategory(limit: limit, offset: offset, categoryID: hallID) { (valid, msg, halls) in
            self.dismissRingIndecator()
            if valid{
                if halls.count > 0 {
                    for record in halls {
                        self.allHalls.append(record)
                    }
                    self.collectionView2.reloadData()
                }
            }else{
               
            }
            self.isFinishedPaging = true
        }
    }
    

    
// MARK :- Helper functions
/********************************************************************************************/
    func setupLeftMenuDelegetes(){
      leftMenu1.homeController = self
      leftMenu2.homeController = self
   }
    func showLoginComponent(){
        menuLeftNavigationController.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "signInScreen") as! SignInController
            let homeController = UINavigationController(rootViewController: controller)
            homeController.isNavigationBarHidden = true
            self.present(homeController, animated: true, completion: nil)
        }
    }
    func setupLeftMenu(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController2
        }else{
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        }
    }
    func setupFirstFilter(){
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView1.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    @objc func SearchViewTapped(sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
       navigationController?.pushViewController(controller, animated: true)
    }
    func setupComponent(){
        self.collectionView2.register(UINib(nibName: "HallCell", bundle: nil), forCellWithReuseIdentifier: "HallCell")
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        self.collectionView1.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SearchViewTapped)))
        
        collectionView2.prefetchDataSource = self
        
        searchView.dropShadow(cornerRadius: 25)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .replace
        SideMenuManager.defaultManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuWidth = min(4*(self.view.frame.width/5), 400)
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "logo2")
        iconImage.contentMode = .scaleAspectFit
        iconImage.backgroundColor = UIColor.clear
        navigationItem.titleView = iconImage
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "MenuImage@@@")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.black
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    // MARK :- Side menu subViews functions
/********************************************************************************************/
    func signOut(){
        navigationController?.popToRootViewController(animated: true)
        menuLeftNavigationController2.dismiss(animated: true) {
            UserDefaults.standard.removeObject(forKey: "loggedInClient")
            UserDefaults.standard.synchronize()
            self.setupLeftMenu()
        }
    }
    func goHome(){
         menuLeftNavigationController2.dismiss(animated: true, completion: nil)
         menuLeftNavigationController.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func goFavorites(){
        menuLeftNavigationController2.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FavoritesController") as! FavoritesController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func goMyProfile(){
        menuLeftNavigationController2.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MyProfile") as! MyProfileController
        navigationController?.pushViewController(controller, animated: true)
    }
    func goGiveUsFeedback(){
         menuLeftNavigationController2.dismiss(animated: true, completion: nil)
         menuLeftNavigationController.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GiveUsFeedBack") as! FeedbackController2
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func goPrivacyPolicy(){
         menuLeftNavigationController2.dismiss(animated: true, completion: nil)
         menuLeftNavigationController.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicy") as! PrivacyPolicyController
        navigationController?.pushViewController(controller, animated: true)
    }
    func goTermsOfService(){
         menuLeftNavigationController2.dismiss(animated: true, completion: nil)
         menuLeftNavigationController.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfService") as! TermsOfServiceController
        navigationController?.pushViewController(controller, animated: true)
    }
    func goAboutUs(){
         menuLeftNavigationController2.dismiss(animated: true, completion: nil)
         menuLeftNavigationController.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutUs") as! AboutUsController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    
    
    
}
