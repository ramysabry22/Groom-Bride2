
import UIKit
import Alamofire
import Instructions
import SVProgressHUD
import Kingfisher
import SideMenu
import SCLAlertView

class HomeController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDataSourcePrefetching {

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
    let categories: [HallCategory] = {
        let cat1 = HallCategory(_id: "0", name: "All", image: "AllICON777.png")
        let cat2 = HallCategory(_id: "5d0cbfc9a758321414bf9871", name: "Hotel", image: "HotelICON777")
        let cat3 = HallCategory(_id: "5d0cbfc9a758321414bf9872", name: "Club", image: "ClubICON777")
        let cat4 = HallCategory(_id: "5d0cbfc9a758321414bf9875", name: "Open Air", image: "OpenAirICON777")
        let cat5 = HallCategory(_id: "5d0cbfc9a758321414bf9873", name: "Yacht", image: "YachtICON777")
        let cat6 = HallCategory(_id: "5d0cbfc9a758321414bf9874", name: "Villa", image: "VillaICON777")
        let cat7 = HallCategory(_id: "5d1214f4de675f000488d442", name: "Individual", image: "IndividualICON777")
        
        return [cat1,cat2,cat3,cat4,cat5,cat6,cat7]
    }()
    
    let coachMarksController = CoachMarksController()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstOpenDone() == false {
            self.coachMarksController.start(in: .window(over: self))
            finishCoachMark()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
        if firstOpenDone() == false {
            finishCoachMark()
        }
    }
    
    // MARK :- Fetch Halls
/********************************************************************************************/
    func fetchNewHalls(limit: Int, offset: Int){
        self.isFinishedPaging = false
        ApiManager.listHalls(limit: limit, offset: offset) { (valid, msg, halls) in
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
        guard let hallID = categories[index]._id else {
            print("Hall id not found")
            return
        }
        ApiManager.listHallsByCategory(limit: limit, offset: offset, categoryID: hallID) { (valid, msg, halls) in
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
        
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.color = UIColor.black.withAlphaComponent(0.6)
        
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
    
    
}
