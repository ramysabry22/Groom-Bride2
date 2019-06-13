
import UIKit

class SplashScreenController: UIViewController {

    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
       LoadingActivityIndicator.startAnimating()
      _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(ShowViewController), userInfo: nil, repeats: false)
    }

     @objc func ShowViewController(){
        LoadingActivityIndicator.stopAnimating()
        if firstDownloadDone() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            let homeController = UINavigationController(rootViewController: controller)
          //  homeController.hidesBarsOnSwipe = true
            present(homeController, animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingScreens") as! OnBoardingScreens
            let homeController = UINavigationController(rootViewController: controller)
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

