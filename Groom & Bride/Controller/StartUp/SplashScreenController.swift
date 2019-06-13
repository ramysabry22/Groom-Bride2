
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
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MyProfile") as! MyProfileController
        let loginComponent = UINavigationController(rootViewController: controller)
        loginComponent.isNavigationBarHidden = true
        present(loginComponent, animated: true, completion: nil)
    }
   
    
}

