import UIKit


class DetailedHallController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        infoTextView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mim, quis nostrud exercitation ullamco @ Lorem ipsum dolor *********"
        
        locationView.backgroundColor = UIColor.white
        locationView.layer.cornerRadius = 15
        locationView.layer.borderWidth = 1.5
        locationView.layer.borderColor = UIColor.mainAppPink().cgColor
        locationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnMap)))
        
        setupHallInfo()
    }
 
    func setupHallInfo(){
        self.titleLabel.text = detailedHall?.hallName
        self.priceLabel.text = "\(detailedHall!.hallPrice!) EGP"
        self.ratesLabel.text = "\(detailedHall!.hallRatesCounter!) Rates"
        self.infoTextView.text = detailedHall?.hallDescription
        self.addressLabel.text = detailedHall?.hallAdress
        self.offersTextView.text = detailedHall?.hallSpecialOffers
        if detailedHall!.hallImage.count > 0 && detailedHall!.hallImage.isEmpty == false {
           self.pageControl.numberOfPages = detailedHall!.hallImage.count
           self.pageControl.currentPage = 0
        }else {
            self.pageControl.numberOfPages = 1
            self.pageControl.currentPage = 1
        }
    }
    
    @IBAction func CallButtonAction(_ sender: UIButton) {
        guard let phoneNumber = detailedHall?.hallPhoneNumber else {
            self.show1buttonAlert(title: "Oops", message: "Hall phone number is not available!", buttonTitle: "OK") {
            }
            return
        }
        let number = URL(string: "tel://\(phoneNumber)")
        UIApplication.shared.open(number!)
    }
    
    @objc func viewOnMap(_ sender: UITapGestureRecognizer){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    // MARK:- CollectionView
/*********************************************************************************/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailedHall?.hallImage.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailedHallCustomCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "DetailedHallCustomCell", for: indexPath) as! DetailedHallCustomCell
        
        cell.tag = indexPath.row
        if detailedHall!.hallImage.count > 0 && detailedHall!.hallImage.isEmpty == false {
            let tempImageView : UIImageView! = UIImageView()
            let rowImage = detailedHall?.hallImage[indexPath.row]
            let url = URL(string: "\(rowImage!)")
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
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }

}


