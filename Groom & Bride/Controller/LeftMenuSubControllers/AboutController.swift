
import UIKit
import SCLAlertView
import SVProgressHUD

class AboutController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupConstrains()
        fetchAboutUsData()
    }
    @objc func fetchAboutUsData(){
        
        
        
        
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
        SVProgressHUD.setForegroundColor(UIColor.darkGray)
        
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        
        let firstLabel = UILabel()
        firstLabel.text = "About us"
        firstLabel.font = UIFont.systemFont(ofSize: 18)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.black
        navigationItem.titleView = firstLabel
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackImage@@@")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupConstrains(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 10, right: 15))
        
        
        
        
    }
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor.white
        v.isScrollEnabled = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize = CGSize(width: 0, height: 2000)
        return v
    }()
    let label : UILabel = {
        var label = UILabel()
        label.text = "Email address"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        return label
    }()
    
    
}




