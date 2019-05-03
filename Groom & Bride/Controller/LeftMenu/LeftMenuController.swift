
import UIKit
import Firebase
import SCLAlertView
import Kingfisher

class LeftMenuController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    weak var homeController: HomeController?
    
    let cellId = "cellId"
    let headerID = "Header"
    let settingOptions: [[String]] = [["Give us feedback","FeedbackICON"],["Privacy policy","PrivacyPolicyICON"],["Terms of service","TermsOfServiceICON"],["About us","TermsOfServiceICON"]]
    
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
        cell.backgroundColor = UIColor.white
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
            let controller = FeedBackController()
            self.navigationController?.pushViewController(controller, animated: true)
            return
        case 1:
             OpenPrivacyPolicy()
            return
        case 2:
             OpenTermsOfService()
            return
        case 3:
           
            return
        case 4:
            
            return
        default:
            return
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! LeftMenuHeader
        
    
        header.SignInButton.addTarget(self, action: #selector(SignInButtonAction), for: .touchUpInside)
        header.backgroundColor = UIColor.mainColor2()
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let headerHeight = min(collectionView.frame.height/8, 300)
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    
    //   MARK :- Helper Methods
/**********************************************************************************************/
    @objc func SignInButtonAction(){
        self.homeController?.showLoginComponent()
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
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        collectionView.register(LeftMenuHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        collectionView.register(LeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    
}


