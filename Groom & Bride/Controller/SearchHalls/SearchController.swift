
import UIKit
import SVProgressHUD

class SearchController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var emptyLabel: UILabel!
    var searchHallResult: [Hall] = []
    var isFinishedPaging = true
    var pagesNumber: Int = 0
    var SearchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        SVProgressHUD.setupView()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(yourNameFunction), for: UIControl.Event.editingChanged)

        self.collectionView1.register(UINib(nibName: "HallCell", bundle: nil), forCellWithReuseIdentifier: "HallCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.prefetchDataSource = self
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    
    func searchHalls(limit: Int, offset: Int){
        ApiManager.searchHallByName(limit: limit, offset: offset, hallName: SearchText) { (valid, msg, halls) in
          self.dismissRingIndecator()
            if valid {
                if halls.count > 0 {
                    self.searchHallResult = halls
                    self.collectionView1.reloadData()
                    self.emptyLabel.isHidden = true
                }
            }else {
                self.searchHallResult.removeAll()
                self.collectionView1.reloadData()
                self.emptyLabel.isHidden = false
            }
        }
    }
    
    func paginateSearchHalls(limit: Int, offset: Int){
        self.isFinishedPaging = false
        ApiManager.searchHallByName(limit: limit, offset: offset, hallName: SearchText) { (valid, msg, halls) in
            self.dismissRingIndecator()
            self.isFinishedPaging = true
            if valid {
                if halls.count > 0 {
                    for record in halls {
                        self.searchHallResult.append(record)
                    }
                    self.collectionView1.reloadData()
                    self.emptyLabel.isHidden = true
                }
            }else {
                
            }
        }
    }
    func searchTapped(){
        guard let searchText = searchTextField.text,  searchTextField.text?.isEmpty == false, searchTextField.text?.IsValidString() ?? false else {
            self.searchHallResult.removeAll()
            self.collectionView1.reloadData()
            self.emptyLabel.isHidden = false
            return
        }
        searchTextField.endEditing(true)
        self.pagesNumber = 0
        self.SearchText = searchText
        SVProgressHUD.show()
        searchHalls(limit: 7, offset: 0)
    }
    @IBAction func SearchButtonTapped(_ sender: UIButton) {
       searchTapped()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTapped()
        return false
    }
    
    @objc func yourNameFunction(sender: UITextField) {
        if sender.text!.isEmpty {
            // textfield is empty
            self.searchHallResult.removeAll()
            self.collectionView1.reloadData()
            self.emptyLabel.isHidden = false
        } else {
            // text field is not empty
        }
    }
    

    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "logo2")
        iconImage.contentMode = .scaleAspectFit
        iconImage.backgroundColor = UIColor.clear
        navigationItem.titleView = iconImage
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON77777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.mainAppPink()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        searchTextField.endEditing(true)
       navigationController?.popViewController(animated: true)
    }
    
}
