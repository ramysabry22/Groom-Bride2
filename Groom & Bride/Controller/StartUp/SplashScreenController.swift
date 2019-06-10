
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
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "signInScreen") as! SignInController
        let loginComponent = UINavigationController(rootViewController: controller)
        loginComponent.isNavigationBarHidden = true
        present(loginComponent, animated: true, completion: nil)
        
       // present(OnBoardingScreens(), animated: true, completion: nil)
        
    }
   
    
}

