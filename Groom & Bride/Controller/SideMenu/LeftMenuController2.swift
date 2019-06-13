
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
        collectionView.reloadData()
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.mainColor2()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.isNavigationBarHidden = true
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
        
        let cellHeight = min(view.frame.height/12, 80)
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        switch indexPath.item {
        case 0:
//            let controller = SavedHallsController()
//            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 1:
//            let controller = FeedBackController()
//            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 2:
//            let controller = PrivacyPolicyController()
//            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 3:
//            let controller = TermsOfServiceController()
//            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 4:
//            let controller = AboutController()
//            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 5:
            //            let controller = AboutController()
            //            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 6:
            //            let controller = AboutController()
            //            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 7:
            //            let controller = AboutController()
            //            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 5:
//            let appearance = SCLAlertView.SCLAppearance(
//                showCloseButton: false,
//                showCircularIcon: false
//            )
//            let alertView = SCLAlertView(appearance: appearance)
//            let button1 = alertView.addButton("Logout", target: self, selector: #selector(handleLogout))
//            let button2 = alertView.addButton("Cancel"){}
//            alertView.showInfo("Warning!", subTitle: "Logout ?")
//            button1.backgroundColor = UIColor.gray
//            button2.backgroundColor = UIColor.gray
            return
        default:
            return
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! LeftMenuHeader2
        
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            header.nameLabel.text = HelperData.sharedInstance.loggedInClient.userName
            header.emailLabel.text = HelperData.sharedInstance.loggedInClient.userEmail
          //  header.editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        }
        
        header.backgroundColor = UIColor.white
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let headerHeight = min(view.frame.height/3, 500)
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    
    //   MARK :- Helper Methods
/**********************************************************************************************/
    @objc func editButtonAction(){
//        let controller = SettingController()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func  handleLogout() {
        homeController?.signOut()
    }
    private func OpenTermsOfService(){
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    private func OpenPrivacyPolicy(){
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    //   MARK :- Components
/**********************************************************************************************/
    private func setupViews(){
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: -20, left: 0, bottom: 0, right: 0))
        
        collectionView.register(LeftMenuHeader2.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        collectionView.register(LeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.mainAppPink()
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.bounces = false
        return cv
    }()
    
    
}


