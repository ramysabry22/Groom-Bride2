
import UIKit
import Alamofire
import SVProgressHUD

class TermsOfServiceController: UIViewController {
    @IBOutlet weak var textView1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchPTerms()
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    
    func fetchPTerms(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        SVProgressHUD.show()
        ApiManager.sharedInstance.showTerms { (valid, data) in
            self.dismissRingIndecator()
            if valid {
                self.textView1.text = data
            }else {
                self.show1buttonAlert(title: "Error", message: "Unexpected Error Please Try Again In A While", buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Terms Of Service"
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON77777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.mainAppPink()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
}
