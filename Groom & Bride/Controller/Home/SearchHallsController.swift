
import UIKit
import Foundation
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher
import SideMenu
import DropDown

class SearchHallsController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    let cellId = "cellId"
    let cellId2 = "cellId22"
    var allHalls: [Hall] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    @objc func searchButtonTapped(){
        
        
        
        
        
        
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor.mainColor2()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.mainColor2()
        self.navigationController?.isNavigationBarHidden = false
        
        let firstLabel = UILabel()
        firstLabel.text = "Search hall"
        firstLabel.font = UIFont.systemFont(ofSize: 18)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.white
        navigationItem.titleView = firstLabel
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackImage@@@")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.white
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonTapped(){
        self.navigationController?.popViewController(animated: true)
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
    @objc func finishedSearchingTapped(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    // MARK :- CollectionView
    /********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCustomCell
//            let rowHall = allHalls[indexPath.item]
//            cell.nameLabel.text = rowHall.hallName
//            cell.priceLabel.text = rowHall.hallPrice+" LE"
//            
//            if rowHall.hallImage.count > 0 && rowHall.hallImage.isEmpty == false{
//                let stringUrl = "\(HelperData.sharedInstance.serverBasePath)/\(rowHall.hallImage[0])"
//                let encodedString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                let url = URL(string: encodedString!)
//                cell.imageView.kf.indicatorType = .activity
//                cell.imageView.kf.setImage(with: url, options: [.memoryCacheExpiration(.never)])
//            }
            
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 0
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     return CGSize(width: view.frame.width-10, height: min(self.collectionView.frame.height/3, 300))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let rowHall = allHalls[indexPath.row]
//        let detailedController = DetailedHallController()
//        detailedController.detailedHall = rowHall
//        navigationController?.pushViewController(detailedController, animated: true)
    }
    
    // MARK :- Views
    /********************************************************************************************/
    func setupViews(){
        view.addSubview(mainSTackView)
        mainSTackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        mainSTackView.addArrangedSubview(searchAreaView)
        searchAreaView.anchor(top: mainSTackView.topAnchor, leading: mainSTackView.leadingAnchor, bottom: nil, trailing: mainSTackView.trailingAnchor,size: CGSize(width: 0, height: 45))
        
        
        searchAreaView.addSubview(lineSeparator)
        lineSeparator.anchor(top: nil, leading: searchAreaView.leadingAnchor, bottom: searchAreaView.bottomAnchor, trailing: searchAreaView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 1))
        
        searchAreaView.addSubview(searchImageview)
        searchImageview.anchor(top: searchAreaView.topAnchor, leading: searchAreaView.leadingAnchor, bottom: lineSeparator.topAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 10, right: 0), size: CGSize(width: 25, height: 0))
        
        searchAreaView.addSubview(searchButton)
        searchButton.anchor(top: searchAreaView.topAnchor, leading: nil, bottom: lineSeparator.topAnchor, trailing: searchAreaView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 15), size: CGSize(width: 60, height: 0))
        
        searchAreaView.addSubview(searchTextfiled)
        searchTextfiled.anchor(top: searchAreaView.topAnchor, leading: searchImageview.trailingAnchor, bottom: lineSeparator.topAnchor, trailing: searchButton.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: CGSize(width: 0, height: 0))

       
        mainSTackView.addArrangedSubview(collectionView)
        collectionView.anchor(top: searchAreaView.bottomAnchor, leading: mainSTackView.leadingAnchor, bottom: nil, trailing: mainSTackView.trailingAnchor)
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
    let searchButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Search", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.mainColor2(), for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var searchTextfiled: UITextField = {
        let tx = UITextField()
        tx.placeholder = "Search halls"
        tx.tintColor = UIColor.lightGray
        tx.textColor = UIColor.darkGray
        tx.font = UIFont(name: "FontAwesome", size: 14)
        tx.autocorrectionType = UITextAutocorrectionType.no
        tx.keyboardType = UIKeyboardType.default
        tx.returnKeyType = UIReturnKeyType.done
        tx.clearButtonMode = UITextField.ViewMode.whileEditing
        tx.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tx.delegate = self
        tx.returnKeyType = .search
        return tx
    }()

    
}






