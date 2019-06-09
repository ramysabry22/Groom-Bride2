
import UIKit
import Foundation
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher
import SideMenu
import DropDown

protocol loginComponentDelegete : NSObjectProtocol {
    func didBackButtonPressed()
}

class HomeController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout ,loginComponentDelegete, UIGestureRecognizerDelegate{
    func didBackButtonPressed() {
//         self.navigationController?.isNavigationBarHidden = false
//        print("%%%%% ^^^^^ %%%%%%%")
//        setupLeftMenu()
    }
    let cellId = "cellId"
    let cellId2 = "cellId22"
    var allHalls: [Hall] = []
    var filterItems: [String] = ["All", "Hotel", "Club", "Yacht", "Villa", "Open area", "Individual"]
    var firstOpen = true
    let leftMenu1 = LeftMenuController()
    lazy var menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenu1)
    
    let leftMenu2 = LeftMenuController2()
    lazy var menuLeftNavigationController2 = UISideMenuNavigationController(rootViewController: leftMenu2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        if firstDownload() {
            if firstOpen {
                setupViews()
               // fetchHalls()
                
                firstOpen = false
                setupFirstFilter() 
            }
           setupNavigationBar()
           setupLeftMenu()
        }else if !firstDownload(){
            self.navigationController?.isNavigationBarHidden = true
            let onBoardingController = OnBoardingScreens()
           present(onBoardingController, animated: true, completion: nil)
        }
    }
    func fetchHalls(){
//        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
//            sessionDataTask.forEach { $0.cancel() }
//            uploadData.forEach { $0.cancel() }
//            downloadData.forEach { $0.cancel() }
//        }
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        ApiManager.sharedInstance.getAllHalls { (valid, msg, halls) in
            self.dismissRingIndecator()
            if valid{
                self.allHalls = halls
                self.collectionView.reloadData()
            }else {
                self.PresentCustomError(error: msg)
            }
        }
    }
    func showLoginComponent(){
        menuLeftNavigationController.dismiss(animated: true) {
            let controller = LoginComponentNavigationController()
            controller.delegateee = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    func signOut(){
        menuLeftNavigationController2.dismiss(animated: true) {
            UserDefaults.standard.removeObject(forKey: "loggedInClient")
            UserDefaults.standard.synchronize()
            self.setupLeftMenu()
        }
    }
    func setupLeftMenu(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
//             let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: LeftMenuController2())
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController2
        }else{
           //  let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenu1)
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        }
    }
    @objc func searchLabelTapped(_ sender: UITapGestureRecognizer){
        let searchController = SearchHallsController()
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor.mainColor2()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.mainColor2()
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
     
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .preserve
        SideMenuManager.defaultManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuWidth = min(4*(self.view.frame.width/5), 400)
        
        let firstLabel = UILabel()
        firstLabel.text = "Groom & Bride"
        firstLabel.font = UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 19)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.white
        navigationItem.titleView = firstLabel
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "MenuImage@@@")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.white.withAlphaComponent(0.7)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
    fileprivate func firstDownload() -> Bool {
        if UserDefaults.standard.bool(forKey: "isFirstDownloadDone"){
            return true
        }
        else {
            return false
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

    func setupFirstFilter(){
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        filterCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    fileprivate func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: self.view.frame.width, height: 45)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 14)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }


// MARK :- CollectionView
/********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView { return 8 }
            //allHalls.count }
        else if collectionView == self.filterCollectionView { return filterItems.count }
        else { return allHalls.count }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCustomCell
            
//        cell.tag = indexPath.row
//        let rowHall = allHalls[indexPath.item]
//        cell.nameLabel.text = rowHall.hallName
//        cell.priceLabel.text = rowHall.hallPrice+" LE"
//        cell.imageView.image = UIImage(named: "HomeBackgroundImage")
//
//       let tempImageView : UIImageView! = UIImageView()
//
//        if rowHall.hallImage.count > 0 && rowHall.hallImage.isEmpty == false{
//            let stringUrl = "\(HelperData.sharedInstance.serverBasePath)/\(rowHall.hallImage[0])"
//            let encodedString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let url = URL(string: encodedString!)
//            tempImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
//                if(cell.tag == indexPath.row){
//                    if result.isSuccess == false{
//                        cell.imageView.image = UIImage(named: "HomeBackgroundImage")
//                    }else{
//                        cell.imageView.image = tempImageView.image
//                    }
//                }
//            }
//        }

        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 0
        return cell
            
        }else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! HomeFilterCustomCell
            
            cell2.titleLabel.text = filterItems[indexPath.row]
            cell2.backgroundColor = UIColor.clear
            return cell2
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView {
        return CGSize(width: view.frame.width-10, height: min(self.collectionView.frame.height/3, 300))
        }else {
            let rowItem = filterItems[indexPath.row]
            var width: CGFloat = 30
              width += estimateFrameForText(rowItem).width
            return CGSize(width: width, height: 45)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
           let rowHall = allHalls[indexPath.row]
           let detailedController = DetailedHallController()
           detailedController.detailedHall = rowHall
           navigationController?.pushViewController(detailedController, animated: true)
        }else if collectionView == self.filterCollectionView {
        
            print("filter by: ",filterItems[indexPath.row])
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if(velocity.y > 0) {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions(), animations: {

              //  self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.searchAreaView.isHidden = true
                self.filterCollectionView.isHidden = true
                self.searchLabel.isHidden = true
                self.searchImageview.isHidden = true
                self.filterImageview.isHidden = true

            }, completion: nil)

        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions(), animations: {

              //  self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.searchAreaView.isHidden = false
                self.filterCollectionView.isHidden = false
                
                self.searchLabel.isHidden = false
                self.searchImageview.isHidden = false
                self.filterImageview.isHidden = false
                
            }, completion: nil)
        }
    }
    
    
// MARK :- Components Setup
/********************************************************************************************/
    func setupViews(){
    leftMenu1.homeController = self
    leftMenu2.homeController = self
        
        view.addSubview(mainSTackView)
        mainSTackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
           mainSTackView.addArrangedSubview(searchAreaView)
        searchAreaView.anchor(top: mainSTackView.topAnchor, leading: mainSTackView.leadingAnchor, bottom: nil, trailing: mainSTackView.trailingAnchor,size: CGSize(width: 0, height: 45))
    
        
           searchAreaView.addSubview(lineSeparator)
        lineSeparator.anchor(top: nil, leading: searchAreaView.leadingAnchor, bottom: searchAreaView.bottomAnchor, trailing: searchAreaView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 1))
        
           searchAreaView.addSubview(searchImageview)
        searchImageview.anchor(top: searchAreaView.topAnchor, leading: searchAreaView.leadingAnchor, bottom: lineSeparator.topAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 10, right: 0), size: CGSize(width: 25, height: 0))
        
    
            searchAreaView.addSubview(filterImageview)
        filterImageview.anchor(top: searchAreaView.topAnchor, leading: nil, bottom: lineSeparator.topAnchor, trailing: searchAreaView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 15), size: CGSize(width: 25, height: 0))
        
          searchAreaView.addSubview(searchLabel)
        searchLabel.anchor(top: searchAreaView.topAnchor, leading: searchImageview.trailingAnchor, bottom: lineSeparator.topAnchor, trailing: filterImageview.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: CGSize(width: 0, height: 0))
    
        
        mainSTackView.addArrangedSubview(filterCollectionView)
        filterCollectionView.anchor(top: searchAreaView.bottomAnchor, leading: mainSTackView.leadingAnchor, bottom: nil, trailing: mainSTackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 45))
        filterCollectionView.register(HomeFilterCustomCell.self, forCellWithReuseIdentifier: cellId2)
        
        mainSTackView.addArrangedSubview(collectionView)
        collectionView.anchor(top: filterCollectionView.bottomAnchor, leading: mainSTackView.leadingAnchor, bottom: nil, trailing: mainSTackView.trailingAnchor)
        collectionView.register(HomeCustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    let mainSTackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 0
        return sv
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.keyboardDismissMode = .interactive
        return cv
    }()
    lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.keyboardDismissMode = .interactive
        return cv
    }()
    let searchAreaView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    let lineSeparator: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return iv
    }()
    let searchImageview : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "SearchImage@@@")?.withRenderingMode(.alwaysTemplate)
        image.layer.cornerRadius = 0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.gray
        return image
    }()
    lazy var filterImageview : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "FilterImage@@@")?.withRenderingMode(.alwaysTemplate)
        image.layer.cornerRadius = 0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.gray
        image.isUserInteractionEnabled = true
        return image
    }()
    lazy var searchLabel : UILabel = {
        var label = UILabel()
        label.text = "Search halls"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(searchLabelTapped(_:)))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
}

