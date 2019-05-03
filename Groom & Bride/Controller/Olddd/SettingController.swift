
import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import SCLAlertView
import SVProgressHUD


class SettingController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let headerID = "Header"
    let settings: [[String]] = [["Notifications","News notifications"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        setupConstrains()
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true

    }
    
// MARK :- Collectionview Methods
/********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) 
        
        let title = UILabel(frame: CGRect(x: 20, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
        title.textColor = UIColor.black
        title.text = settings[indexPath.row][1]
        title.textAlignment = .left
        cell.contentView.addSubview(title)
       
        if indexPath.section == 0 {
            let switchView = UISwitch(frame: CGRect(x: cell.frame.width-70, y: 7.5, width: 50, height: 30))
            switchView.setOn(true, animated: true)
            switchView.onTintColor = UIColor.mainColor2()
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            
          cell.contentView.addSubview(switchView)
        }
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 6
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: view.frame.width-30, height: 45)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CustomHeader
        header.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    
        header.customLabel.text = settings[indexPath.section][0]
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 40)
    }
    
// MARK :-   Main Methods
/********************************************************************************************/
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    @objc func backButtonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
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
    func PresentCustomSuccess(error: String){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let button1 = alertView.addButton("OK"){
            self.navigationController?.popViewController(animated: true)
        }
        alertView.showInfo("Done!", subTitle: "\(error)")
        button1.backgroundColor = UIColor.gray
    }
    
    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupConstrains(){
        let firstLabel = UILabel()
        firstLabel.text = "Settings"
        firstLabel.font = UIFont.boldSystemFont(ofSize: 19)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.gray
        view.addSubview(firstLabel)
        firstLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 44))
        
        view.addSubview(backButton)
        backButton.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0),size: CGSize(width: 24, height: 20))
        backButton.centerYAnchor.constraint(equalTo: firstLabel.centerYAnchor).isActive = true
        
//        view.addSubview(imageView)
//        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 50, height: 50))
//        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        view.addSubview(collectionView)
        collectionView.anchor(top: firstLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        collectionView.register(CustomHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    
    // MARK :-  Setup Component
    /********************************************************************************************/
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
        //  layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
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
    let backButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("", for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "backButtonIOCN"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.image = UIImage(named: "logo1")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    
    
}





class CustomHeader: UICollectionViewCell {
     let customLabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        
        customLabel.text = "User Account"
        customLabel.font = UIFont.boldSystemFont(ofSize: 14)
        customLabel.textAlignment = .left
        customLabel.numberOfLines = 0
        customLabel.textColor = UIColor.gray
        
        
        self.contentView.addSubview(customLabel)
        let margins = contentView.layoutMarginsGuide
        self.contentView.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        customLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        customLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        customLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        customLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
