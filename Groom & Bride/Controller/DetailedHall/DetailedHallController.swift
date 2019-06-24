import UIKit
import SVProgressHUD
import Cosmos

class DetailedHallController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var ratingStarsView: CosmosView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteBackgroundView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var offersTextView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    
    var detailedHall: Hall?
    var favoriteDetailedHall: FavoriteHall?
    
    var hallName: String?
    var hallId: String?
    var hallAddress: String?
    var hallLocationLong: String?
    var hallLocationLat: String?
    var hallPhoneNumber: String?
    var hallImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupComponents()
        setupHallInfo()
    }
   
    func setupComponents(){
        collectionView1.delegate = self
        collectionView1.dataSource = self
        locationView.backgroundColor = UIColor.white
        locationView.layer.cornerRadius = 15
        locationView.layer.borderWidth = 1.5
        locationView.layer.borderColor = UIColor.mainAppPink().cgColor
        locationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnMap)))
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTofavoriteButtonAction)))
        favoriteBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addTofavoriteButtonAction)))
    }
    func setupHallInfo(){
        if detailedHall != nil {
            hallLocationLat = detailedHall?.hallLocationLat
            hallLocationLong = detailedHall?.hallLocationLong
            hallImages = (detailedHall?.hallImage)!
            hallId = detailedHall?._id
            hallPhoneNumber = detailedHall?.hallPhoneNumber
            hallAddress = detailedHall?.hallAdress
            hallName = detailedHall?.hallName
            
           titleLabel.text = hallName
           addressLabel.text = hallAddress
           priceLabel.text = "\(detailedHall?.hallPrice ?? 0) EGP"
           ratingStarsView.rating = Double(detailedHall?.hallRate ?? 0)
           ratesLabel.text = "\(detailedHall?.hallRatesCounter ?? 0) Rates"
           infoTextView.text = detailedHall?.hallDescription
           offersTextView.text = detailedHall?.hallSpecialOffers
            
            if detailedHall?.hallImage.count ?? 0 > 0 && detailedHall?.hallImage.isEmpty == false {
                hallImages = (detailedHall?.hallImage)!
                self.pageControl.numberOfPages = hallImages.count
                self.pageControl.currentPage = 0
            }
           
            favoriteImageView.isHidden = false
            favoriteBackgroundView.isHidden = false
            
        }else if favoriteDetailedHall != nil {
            hallLocationLat = favoriteDetailedHall?.hallId.hallLocationLat
            hallLocationLong = favoriteDetailedHall?.hallId.hallLocationLong
            hallImages = (favoriteDetailedHall?.hallId.hallImage)!
            hallId = favoriteDetailedHall?.hallId._id
            hallPhoneNumber = favoriteDetailedHall?.hallId.hallPhoneNumber
            hallAddress = favoriteDetailedHall?.hallId.hallAdress
            hallName = favoriteDetailedHall?.hallId.hallName
            
            titleLabel.text = hallName
            addressLabel.text = hallAddress
            priceLabel.text = "\(favoriteDetailedHall?.hallId.hallPrice ?? 0) EGP"
            ratingStarsView.rating = Double(favoriteDetailedHall?.hallId.hallsAverageRating ?? 0)
            ratesLabel.text = "\(favoriteDetailedHall?.hallId.hallsRatingCounter ?? 0) Rates"
            infoTextView.text = favoriteDetailedHall?.hallId.hallDescription
            offersTextView.text = favoriteDetailedHall?.hallId.hallSpecialOffers
            
            if favoriteDetailedHall?.hallId.hallImage.count ?? 0 > 0 && favoriteDetailedHall?.hallId.hallImage.isEmpty == false {
                hallImages = (favoriteDetailedHall?.hallId.hallImage)!
                self.pageControl.numberOfPages = hallImages.count
                self.pageControl.currentPage = 0
            }
            
            favoriteImageView.isHidden = true
            favoriteBackgroundView.isHidden = true
        }
    }

    @IBAction func CallButtonAction(_ sender: UIButton) {
        guard let phoneNumber = hallPhoneNumber, hallPhoneNumber != nil else {
            self.show1buttonAlert(title: "Oops", message: "Hall phone number is not available!", buttonTitle: "OK") {
            }
            return
        }
        let encodedPhoneNumber = phoneNumber.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let number = URL(string: "tel://" + "\(encodedPhoneNumber!)")
        UIApplication.shared.open(number!)
    }
    
    @objc func viewOnMap(_ sender: UITapGestureRecognizer){
        guard let Longitude = hallLocationLong, let Latitude = hallLocationLat, let Name = hallName, let Address = hallAddress else {
            self.show1buttonAlert(title: "Oops", message: "Hall location is not available!", buttonTitle: "OK") {
                
            }
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        controller.hallLat = (Latitude as NSString).floatValue
        controller.hallLong = (Longitude as NSString).floatValue
        controller.hallName = Name
        controller.hallAddress = Address
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func addTofavoriteButtonAction(){
        if defaults.dictionary(forKey: "loggedInClient") != nil{
            addToFavorite()
        }else {
            showLoginComponent()
        }
    }
    func addToFavorite(){
        guard let hallID = hallId else { return }
        SVProgressHUD.show()
        ApiManager.sharedInstance.addHallToFavorite(hallID: hallID) { (valid, msg, reRequest) in
          self.dismissRingIndecator()
            if reRequest {
                self.addToFavorite()
            }
            else if valid {
                self.favoriteImageView.image = UIImage(named: "HeartICONSelected777")
                self.show1buttonAlert(title: "Done", message: "Hall saved to favorite successfullt", buttonTitle: "OK", callback: {
                
                })
            }else {
                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "OK", callback: {

                })
            }
        }
    }
    func showLoginComponent(){
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "signInScreen") as! SignInController
        let homeController = UINavigationController(rootViewController: controller)
        homeController.isNavigationBarHidden = true
        self.present(homeController, animated: true, completion: nil)
    }
    
    // MARK:- CollectionView
/*********************************************************************************/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hallImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailedHallCustomCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "DetailedHallCustomCell", for: indexPath) as! DetailedHallCustomCell
        
        cell.tag = indexPath.row
        if hallImages.count > 0 && hallImages.isEmpty == false {
            let tempImageView : UIImageView! = UIImageView()
            let rowImage = hallImages[indexPath.row]
            let url = URL(string: "\(rowImage)")
            tempImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                if(cell.tag == indexPath.row){
                    if result.isSuccess == false{
                        cell.imageView.image = UIImage(named: "logo1")
                    }else{
                        cell.imageView.image = tempImageView.image
                    }
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView1.frame.width, height: collectionView1.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        self.pageControl.currentPage = pageNumber
        self.pageControl.updateCurrentPageDisplay()
    }
   

    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
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
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
}


