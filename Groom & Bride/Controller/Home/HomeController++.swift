
import UIKit
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher
import SideMenu
import DropDown

extension HomeController {
    
    // MARK :- Side menu subViews functions
    /********************************************************************************************/
    
    func signOut(){
        self.show2buttonAlert(title: "Logout?", message: "Are you sure you want to logout?", cancelButtonTitle: "Cancel", defaultButtonTitle: "OK") { (yes) in
            if yes {
                self.navigationController?.popToRootViewController(animated: true)
                UserDefaults.standard.removeObject(forKey: "loggedInClient")
                UserDefaults.standard.synchronize()
                self.setupLeftMenu()
            }
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

