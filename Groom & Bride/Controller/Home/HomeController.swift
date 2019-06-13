
import UIKit
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher
import SideMenu
import DropDown

class HomeController: UIViewController, UIGestureRecognizerDelegate{
    let leftMenu1 = LeftMenuController()
    lazy var menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenu1)
    let leftMenu2 = LeftMenuController2()
    lazy var menuLeftNavigationController2 = UISideMenuNavigationController(rootViewController: leftMenu2)
    
    var allHalls: [Hall] = []
    var filterItems: [String] = ["All", "Hotel", "Club", "Yacht", "Villa", "Open Air", "Individual"]
    var firstOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        if firstOpen {
            setupLeftMenuDelegetes()
            setupNavigationBar()
           // fetchHalls()
            
            firstOpen = false
        }
       setupLeftMenu()
    }
    
    
    
    // MARK :- Fetch Halls
/********************************************************************************************/
    
    
    
    
    
    
    

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
    func signOut(){
        menuLeftNavigationController2.dismiss(animated: true) {
            UserDefaults.standard.removeObject(forKey: "loggedInClient")
            UserDefaults.standard.synchronize()
            self.setupLeftMenu()
            // remove from logged in client
        }
    }
    func setupLeftMenu(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController2
        }else{
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        }
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
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .preserve
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
    
    
    //    func setupFirstFilter(){
    //        let selectedIndexPath = IndexPath(item: 0, section: 0)
    //        filterCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    //    }
}
