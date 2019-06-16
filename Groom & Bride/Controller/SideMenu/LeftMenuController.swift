
import UIKit
import Firebase
import SCLAlertView
import Kingfisher

class LeftMenuController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    weak var homeController: HomeController?
    
    let cellId = "cellId"
    let headerID = "Header"
    let settingOptions: [[String]] = [["Home","HomeICON777"],["Give us feedback","GiveUsFeedBackICON777"],["Privacy policy","PrivacyPolicyICON777"],["Terms of service","TermsOfServiceICON777"],["About us","AboutUsICON777"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
   
    
    // MARK :- Collectionview Methods
/********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingOptions.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LeftMenuCell
        
        cell.titleLabel.text = settingOptions[indexPath.item][0]
        cell.iconImage.image = UIImage(named: "\(settingOptions[indexPath.item][1])")?.withRenderingMode(.alwaysTemplate)
        cell.iconImage.tintColor = UIColor.white
        cell.backgroundColor = UIColor.mainAppPink()
        cell.layer.cornerRadius = 0
        
        if indexPath.item == settingOptions.count-1 {
            cell.lineView.isHidden = true
        }else {
            cell.lineView.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = min(view.frame.height/12, 80)
        let cellHeight = max(x, 50)
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
           self.homeController?.navigationController?.popToRootViewController(animated: false)
           self.dismiss(animated: true, completion: nil)
            return
        case 1:
            self.homeController?.goGiveUsFeedback()
            self.dismiss(animated: true, completion: nil)
            return
        case 2:
            self.homeController?.goPrivacyPolicy()
            self.dismiss(animated: true, completion: nil)
            return
        case 3:
            self.homeController?.goTermsOfService()
            self.dismiss(animated: true, completion: nil)
            return
        case 4:
            self.homeController?.goAboutUs()
             self.dismiss(animated: true, completion: nil)
            return
        default:
            return
        }
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! LeftMenuHeader
//
//
//        header.loginButton.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
//        header.registerButton.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
//        header.backgroundColor = UIColor.white
//        return header
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        let headerHeight = min(view.frame.height/3, 500)
//        return CGSize(width: view.frame.width, height: headerHeight)
//    }
    
    
    //   MARK :- Helper Methods
/**********************************************************************************************/
    @objc func SignInButtonAction(){
        self.homeController?.showLoginComponent()
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    //   MARK :- Components
/**********************************************************************************************/
    private func setupViews(){
        view.addSubview(collectionView)
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let x = min(view.frame.height/3, 500)
        let headerHeight = max(x, 160)
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: CGSize(width: 0, height: headerHeight))
        
        headerView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        let topPadding =  window.safeAreaInsets.top
        
        iconImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: topPadding).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        
        headerView.addSubview(stackview)
        stackview.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 10), size: CGSize(width: 0, height: 45))
        
        stackview.addArrangedSubview(loginButton)
        stackview.addArrangedSubview(registerButton)
        
        let buttonWidth = (view.frame.width-35)/2
        loginButton.anchor(top: stackview.topAnchor, leading: nil, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: buttonWidth, height: 45))
        registerButton.anchor(top: stackview.topAnchor, leading: nil, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: buttonWidth, height: 45))
        
        headerView.addSubview(view1)
        view1.anchor(top: stackview.topAnchor, leading: loginButton.trailingAnchor, bottom: stackview.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 7, bottom: 5, right: 0),size: CGSize(width: 2, height: 45))
        
        headerView.addSubview(view2)
        view2.anchor(top: nil, leading: headerView.leadingAnchor, bottom: stackview.topAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 2))
        
        headerView.addSubview(view3)
        view3.anchor(top: stackview.bottomAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 5))
        
        
        
        
        
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.register(LeftMenuCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.register(LeftMenuHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.mainAppPink()
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    let headerView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo2")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let stackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.distribution  = UIStackView.Distribution.fillEqually
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 15
        return sv
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var registerButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
        return button
    }()
    let view1: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.mainAppPink()
        return iv
    }()
    let view2: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#F3EAEA")
        return iv
    }()
    let view3: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#F3EAEA")
        return iv
    }()
    
}


