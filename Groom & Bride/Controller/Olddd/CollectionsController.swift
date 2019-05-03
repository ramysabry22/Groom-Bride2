
import UIKit
import Firebase

class CollectionsController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    let cellId = "cellId"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        
    }
    func setupNavigationBar(){
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        //    self.navigationController?.isNavigationBarHidden = true
        
        let firstLabel = UILabel()
        firstLabel.text = "Collections"
        firstLabel.font = UIFont(name: "Palatino-Bold", size: 19)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.gray
     //   navigationItem.titleView = firstLabel
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchBar.sizeToFit()
    }
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar(frame: CGRect.zero)
        sb.placeholder = "Search For Hall"
        sb.delegate = self
        return sb
    }()
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
// MARK :- Collectionview Methods
/********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionsCustomCell
        
     
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width-40, height: view.frame.height/5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
//        let controller = CategorizedHallsController()
//        controller.passedMenuOption = indexPath.item
//        controller.passedMenuString = menuOptions[indexPath.item].title ?? "Halls"
//        self.navigationController?.pushViewController(controller, animated: true)
    }
  
//   MARK :- Components
/**********************************************************************************************/
    private func setupViews(){
        [collectionView].forEach { view.addSubview($0) }
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
       
        collectionView.register(CollectionsCustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
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
}
