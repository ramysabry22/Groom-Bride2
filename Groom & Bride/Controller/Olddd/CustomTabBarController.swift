
import UIKit

class CustomTabBarController: UITabBarController {
    var firstLogin: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.white
        if !isLoggedIn() {
            DispatchQueue.main.async {
                let HomeNavigationController = UINavigationController(rootViewController: LoginStartScreenController())
                HomeNavigationController.navigationController?.isNavigationBarHidden = true
                self.present(HomeNavigationController, animated: true, completion: nil)
            }
            return
        }else {
            if firstLogin {
                setupTabBar()
            }
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        if UserDefaults.standard.bool(forKey: "IsLoggedIn"){
            return true
        }
        else {
            return false
        }
    }
    fileprivate func firstDownload() -> Bool {
        if UserDefaults.standard.bool(forKey: "firstDownloadDone"){
            return false
        }
        else {
            return true
        }
    }
    
    func setupTabBar(){
        firstLogin = false
        
        let controller1 = UINavigationController(rootViewController: HomeController())
        controller1.title = "Home"
        controller1.tabBarItem.image = UIImage(named: "HomeICON")
        controller1.tabBarItem.selectedImage = UIImage(named: "HomeICONselected")
        
        let controller2 = UINavigationController(rootViewController: CollectionsController())
        controller2.title = "Search"
        controller2.tabBarItem.image = UIImage(named: "SearchICON")
        controller2.tabBarItem.selectedImage = UIImage(named: "SearchICONselected")
        
        let controller3 = UINavigationController(rootViewController: FavoriteController())
        controller3.title = "Saved"
        controller3.tabBarItem.image = UIImage(named: "FavoriteICON")
        controller3.tabBarItem.selectedImage = UIImage(named: "FavoriteICONselected")
        
        let controller4 = UINavigationController(rootViewController: NotificationsController())
        controller4.title = "Notifications"
        controller4.tabBarItem.image = UIImage(named: "NotificationsICON")
        controller4.tabBarItem.selectedImage = UIImage(named: "NotificationsICONselected")
        
        let controller5 = UINavigationController(rootViewController: MoreController())
        controller5.title = "More"
        controller5.tabBarItem.image = UIImage(named: "MoreICON")
        controller5.tabBarItem.selectedImage = UIImage(named: "MoreICONselected")
        
        
        viewControllers = [controller1, controller2, controller3, controller4, controller5]
        
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        tabBar.isHidden = false
        tabBar.isTranslucent = false
        UITabBar.appearance().tintColor = UIColor.mainColor2()// selected item image + title
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray// unselected colors
        UITabBar.appearance().barTintColor = UIColor.white //tabbar background color
    }
    
}
