

import UIKit
import Foundation
import Alamofire
import SVProgressHUD
import SCLAlertView
import Kingfisher


class SavedHallsController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    let cellId = "cellId"
    var allHalls: [Hall] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        fetchUserSavedHalls()
    }
    func fetchUserSavedHalls(){
        
        
        
        
        
        
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor.mainColor2()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.mainColor2()
        self.navigationController?.isNavigationBarHidden = false
        
        let firstLabel = UILabel()
        firstLabel.text = "Saved halls"
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
    
    
    // MARK :- Component Setup
/********************************************************************************************/
    func setupViews(){
          view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        collectionView.register(HomeCustomCell.self, forCellWithReuseIdentifier: cellId)
    }
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

    
}






