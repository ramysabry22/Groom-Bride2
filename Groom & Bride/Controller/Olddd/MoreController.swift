
import UIKit
import Firebase
import SCLAlertView

class MoreController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let headerID = "Header"
    let footerID = "Footer"
    let settingOptions: [[String]] = [["Settings","SettingICON"],["Give us feedback","FeedbackICON"],["Privacy policy","PrivacyPolicyICON"],["Terms of service","TermsOfServiceICON"],["Sign out","SignOutICON"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.mainColor2()
            //UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.mainColor1()
        self.navigationController?.isNavigationBarHidden = true

    }
  
//   MARK :- Fetch user info
/**********************************************************************************************/
    private func fetchUserInfo(){
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//            return
//        }
//        let reference = Database.database().reference().child("EngagedUsers").child(currentUserID)
//        reference.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dictionary = snapshot.value as [String: AnyObject] {
//                DispatchQueue.main.async {
//                    self.
//                }
//            }
//
//
//
//        }, withCancel: nil)
        
        
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomMoreCell

        cell.titleLabel.text = settingOptions[indexPath.item][0]
        cell.Image.image = UIImage(named: "\(settingOptions[indexPath.item][1])")?.withRenderingMode(.alwaysTemplate)
        cell.Image.tintColor = UIColor.gray
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 0
        
        if indexPath.item == 4 {
            cell.lineView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // -30
        return CGSize(width: view.frame.width, height: view.frame.height/10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print(indexPath.item)
        switch indexPath.item {
        case 0:
            let controller = SettingController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 1:
            let controller = FeedBackController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 2:
            OpenPrivacyPolicy()
            return
        case 3:
            OpenTermsOfService()
            return
        case 4:
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false,
                showCircularIcon: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            let button1 = alertView.addButton("Logout", target: self, selector: #selector(handleLogout))
            let button2 = alertView.addButton("Cancel"){}
            alertView.showInfo("Warning!", subTitle: "Logout ?")
             button1.backgroundColor = UIColor.gray
             button2.backgroundColor = UIColor.gray
            return
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CustomMoreHeader
            
            //        if let firstMessageInSection = finalGroupedMesseges[indexPath.section].first {
            //            header.HeaderTitle.text = "\(Date.dateFromCustomString22(customString: firstMessageInSection.time!))"
            //        }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.editButtonTapped(_:)))
            header.EditImage.addGestureRecognizer(tapGesture)
            header.backgroundColor = UIColor.mainColor2()
            header.EditImage.tintColor = UIColor.white
            header.profileImage.tintColor = UIColor.white
            
            header.nameLabel.textColor = UIColor.white
            header.emailLabel.textColor = UIColor.white
            //UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            
            
            if let currentUserID = Auth.auth().currentUser?.uid  {
                let reference = Database.database().reference().child("EngagedUsers").child(currentUserID)
                reference.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        DispatchQueue.main.async {
                            header.nameLabel.text = dictionary["FullName"] as? String
                            header.emailLabel.text = dictionary["Email"] as? String
                        }
                    }
                }, withCancel: nil)
            }
           
            
            
            
            
            
            
            
            // test fr cloud functions
            
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.editButtonTapped22(_:)))
            header.profileImage.addGestureRecognizer(tapGesture2)
            
            
            
            
            // ------------------------------ end
            
            return header
        }
        else  {
             let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! CustomMoreHeader
            
            footer.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            footer.profileImage.isHidden = true
            footer.nameLabel.isHidden = true
            footer.emailLabel.isHidden = true
            footer.EditImage.isHidden = true
            return footer
        }
      
    }
    /**************************************/
     /**************************************/ // testing for cloud functions
    @objc func editButtonTapped22(_ sender: UITapGestureRecognizer){
        print("tapeeeedddddddddddddddddddddddddd")
//        Messaging.messaging().subscribe(toTopic: "highScores") { error in
//            if let err = error {
//                print("Errorrrrrr",err)
//                return
//            }
//
//            print("Subscribed to weather topic")
//        }

        let ref = Database.database().reference()
        let usersReference = ref.child("SendPushNotificationNode")
        let ref2 = usersReference.childByAutoId()
        let timeCreated: String = String(NSDate().timeIntervalSince1970)
        let values: [String : Any] = ["title": "Check new halls", "body": "200 halls was added this week, check them now!", "timeSnap": timeCreated] as [String : Any]
        ref2.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                let _:String = error?.localizedDescription ?? ""
                print("Errorrrr")
                return
            }
           
            print("Done ")
        })
        
        
    }
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerHeight = (view.frame.height-(view.frame.height/3))-(5*(view.frame.height/10))
        
        return CGSize(width: view.frame.width, height: footerHeight)
    }
    
    @objc func editButtonTapped(_ sender: UITapGestureRecognizer){
        print("edit tapped")
        let controller = EditProfileController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func  handleLogout() {
        do{
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "IsLoggedIn")
            UserDefaults.standard.synchronize()
            
            let homeController = LoginStartScreenController()
            let HomeNavigationController = UINavigationController(rootViewController: homeController)
            HomeNavigationController.navigationController?.isNavigationBarHidden = true
            self.present(HomeNavigationController, animated: true, completion: nil)
        }catch let logError{
            print(logError)
            SCLAlertView().showError("Error", subTitle: logError.localizedDescription)
        }
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
        [collectionView].forEach { view.addSubview($0) }
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
         collectionView.register(CustomMoreHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        
         collectionView.register(CustomMoreHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerID)
        
        collectionView.register(CustomMoreCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
      //  layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.mainColor2()
            //UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
}
