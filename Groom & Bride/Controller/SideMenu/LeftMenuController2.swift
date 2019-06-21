
import UIKit
import Firebase
import SCLAlertView
import Kingfisher

class LeftMenuController2: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
     weak var homeController: HomeController?
    
    let cellId = "cellId"
    let headerID = "Header"
    let settingOptions: [[String]] = [["Home","HomeICON777"],["My profile","MyProfileICON777"],
    ["Saved halls","SavedHallsICON777"],["Give us feedback","GiveUsFeedBackICON777"],["Privacy policy","PrivacyPolicyICON777"],["Terms of service","TermsOfServiceICON777"],["About us","AboutUsICON777"],["Logout","LogOutICON777"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       loadUserInfo()
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
            self.homeController?.goHome()
            return
        case 1:
              self.homeController?.goMyProfile()
            return
        case 2:
            self.homeController?.goFavorites()
            return
        case 3:
            self.homeController?.goGiveUsFeedback()
            return
        case 4:
            self.homeController?.goPrivacyPolicy()
            return
        case 5:
            self.homeController?.goTermsOfService()
            return
        case 6:
            self.homeController?.goAboutUs()
            return
        case 7:
            self.show2buttonAlert(title: "Logout?", message: "Are you sure you want to logout?", cancelButtonTitle: "Cancel", defaultButtonTitle: "OK") { (yes) in
                if yes {
                    self.handleLogout()
                }
            }
            return
        default:
            return
        }
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! LeftMenuHeader2
//
//        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
//            header.nameLabel.text = HelperData.sharedInstance.loggedInClient.userName
//            header.emailLabel.text = HelperData.sharedInstance.loggedInClient.userEmail
//        }
//
//        header.backgroundColor = UIColor.white
//        return header
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        let x = min(view.frame.height/4, 500)
//        let headerHeight = max(x, 160)
//        return CGSize(width: view.frame.width, height: headerHeight)
//    }
    
    
    //   MARK :- Helper Methods
/**********************************************************************************************/
    @objc func  handleLogout() {
        homeController?.signOut()
     //    self.dismiss(animated: true, completion: nil)
    }
    func loadUserInfo(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            nameLabel.text = HelperData.sharedInstance.loggedInClient.userName
            emailLabel.text = HelperData.sharedInstance.loggedInClient.userEmail
        }
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
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let x = min(view.frame.height/3.6, 500)
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
        
        
        headerView.addSubview(view3)
        view3.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 5))
        
        
        headerView.addSubview(stackview)
        stackview.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: headerHeight/10, right: 10))
        
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(emailLabel)
        
        nameLabel.anchor(top: nil, leading: stackview.leadingAnchor, bottom: nil, trailing: stackview.trailingAnchor)
        emailLabel.anchor(top: nil, leading: stackview.leadingAnchor, bottom: nil, trailing: stackview.trailingAnchor)
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.register(LeftMenuCell.self, forCellWithReuseIdentifier: cellId)
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
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 3
        return sv
    }()
    let nameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Name Name Name"
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        titleL.textColor = UIColor.mainAppPink()
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let emailLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Email@Email.com"
        titleL.font = UIFont.systemFont(ofSize: 13)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let view3: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#F3EAEA")
        return iv
    }()
    
}


