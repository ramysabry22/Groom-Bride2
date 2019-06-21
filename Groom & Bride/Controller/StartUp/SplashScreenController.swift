
import UIKit

class SplashScreenController: UIViewController {

    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHalls()
    }
    
     func fetchHalls(){
        LoadingActivityIndicator.startAnimating()
        ApiManager.sharedInstance.listHalls(limit: 5, offset: 0) { (valid, msg, halls) in
            self.LoadingActivityIndicator.stopAnimating()
            if valid{
                self.ShowViewController(halls: halls)
            }else{
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "Retry", callback: {
                     self.fetchHalls()
                })
            }
        }
    }
    

     func ShowViewController(halls: [Hall]){
        if firstDownloadDone() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            controller.allHalls = halls
            let homeController = UINavigationController(rootViewController: controller)
            present(homeController, animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingScreens") as! OnBoardingScreens
            let homeController = UINavigationController(rootViewController: controller)
            controller.halls = halls
            homeController.isNavigationBarHidden = true
            present(homeController, animated: true, completion: nil)
        }
    }
   
    fileprivate func firstDownloadDone() -> Bool {
        if UserDefaults.standard.bool(forKey: "isFirstDownloadDonee"){
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
}

