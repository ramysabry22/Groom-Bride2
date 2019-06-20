
import UIKit
import Alamofire
import SVProgressHUD
import Kingfisher
import SideMenu
import Firebase
import SCLAlertView

class HomeController: UIViewController, UIGestureRecognizerDelegate ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
    var filterCollection: [[String]] = [["All","AllICON777.png"],["Hotel","HotelICON777"],
                                        ["Club","ClubICON777"],["Yacht","YachtICON777"],
                                        ["Villa","VillaICON777"],["Individual","IndividualICON777"],]
    var firstOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView2.register(UINib(nibName: "HallCell", bundle: nil), forCellWithReuseIdentifier: "HallCell")
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        self.collectionView1.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
       
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SearchViewTapped)))
        
        setupFirstFilter()
     //   homee()
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
    }

    
    
    // MARK :- Fetch Halls
/********************************************************************************************/
    
    func homee(){
        
        let ref = Database.database().reference().child("PushNotificationsNode").childByAutoId()
        let timeCreated: String = String(NSDate().timeIntervalSince1970)
        let values: [String: Any] = ["body": "we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa we have added 12342341 2new hall check them now bsor3aaaaaaaaaaaaaaaaaaaaaa",
                                     "title": "ka3at gdeda atdaft ya 3ryas",
                                     "time": timeCreated]
        
        ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("error Sending message !!!!!!!!!!!",error ?? "")
                return
            }
            // succeed ..
            print("*****************************************************")
            print("*****************************************************")
            print("*****************************************************")
            print("Message Sent")
            print("*****************************************************")
        })
        
        
        
        
    }
    
    
    func fetchHalls(){
        ApiManager.sharedInstance.getAllHalls { (valid, msg, [Hall]) in
            
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
    
    
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
    
    func PresentCustomError(error: String){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let button1 = alertView.addButton("Ok"){}
        alertView.showInfo("Error!", subTitle: "\(error)")
        button1.backgroundColor = UIColor.gray
    }
    @objc func SearchViewTapped(sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
       navigationController?.pushViewController(controller, animated: true)
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
        menuLeftNavigationController2.dismiss(animated: true) {
            UserDefaults.standard.removeObject(forKey: "loggedInClient")
            UserDefaults.standard.synchronize()
            self.setupLeftMenu()
        }
    }
    func goFavorites(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FavoritesController") as! FavoritesController
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func goMyProfile(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MyProfile") as! MyProfileController
        navigationController?.pushViewController(controller, animated: false)
    }
    func goGiveUsFeedback(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GiveUsFeedBack") as! FeedbackController2
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func goPrivacyPolicy(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicy") as! PrivacyPolicyController
        navigationController?.pushViewController(controller, animated: false)
    }
    func goTermsOfService(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfService") as! TermsOfServiceController
        navigationController?.pushViewController(controller, animated: false)
    }
    func goAboutUs(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutUs") as! AboutUsController
        navigationController?.pushViewController(controller, animated: false)
    }
    
    
    
    
    
    
    
}
