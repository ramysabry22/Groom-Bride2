
import UIKit
import Firebase


struct notification {
    var title: String?
    var subTitle: String?
    var timeSNap: String?
}


class NotificationsController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var AllNotifications = [notification]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        fetchNotifications()
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        //    self.navigationController?.isNavigationBarHidden = true
        
        let firstLabel = UILabel()
        firstLabel.text = "Notifications"
       // firstLabel.font = UIFont(name: "Palatino-Bold", size: 19)
        firstLabel.font = UIFont.boldSystemFont(ofSize: 19)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.gray
        navigationItem.titleView = firstLabel
    }
    
    
    private func fetchNotifications(){
        let reference = Database.database().reference().child("SendPushNotificationNode").queryLimited(toLast: 8)
        reference.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            var newNotification = notification()
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                newNotification.title = dictionary["title"] as? String
                newNotification.subTitle = dictionary["body"] as? String
                newNotification.timeSNap = dictionary["timeSnap"] as? String
            }
            
            self.AllNotifications.append(newNotification)
            DispatchQueue.main.async {
                self.orderNotifications()
                self.collectionView.reloadData()
            }
        }) { (error) in
            
        }
        
    }
    
    private func orderNotifications(){
        if AllNotifications.isEmpty { return }
        
        let orderedNo = AllNotifications.sorted(by: {
            $0.timeSNap!.compare($1.timeSNap!) == .orderedDescending
        })
        
        AllNotifications = orderedNo
    }
// MARK :- Collectionview Methods
/********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllNotifications.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NotificationsCustomCell
        let notification = AllNotifications[indexPath.item]
        
        cell.titleLabel.text = notification.title
        cell.subTitleLabel.text = notification.subTitle
        
        if let time = notification.timeSNap {
            cell.dateLabel.text = Date.dateFromCustomString(customString: time)
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight: CGFloat = 60
        
        if let texr = AllNotifications[indexPath.item].title {
            cellHeight += estimateFrameForTitleText(texr).height
        }
        if let text = AllNotifications[indexPath.item].subTitle {
            cellHeight += estimateFrameForSubTitleText(text).height
        }
        
        
        
        return CGSize(width: (view.frame.width-30), height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
    }
    
//   MARK :- Components
/**********************************************************************************************/
    private func setupViews(){
        [collectionView].forEach { view.addSubview($0) }
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        
        collectionView.register(NotificationsCustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 13
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    
// MARK : Helping functions
/***********************************************************************/
    fileprivate func estimateFrameForTitleText(_ text: String) -> CGRect {
        let size = CGSize(width: self.view.frame.width-85, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 18)]), context: nil)
    }
    fileprivate func estimateFrameForSubTitleText(_ text: String) -> CGRect {
        let size = CGSize(width: self.view.frame.width-85, height: 1000)
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
    
    
    
}
