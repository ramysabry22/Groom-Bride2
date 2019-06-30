
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView1: MKMapView!
    var hallLong: Float = -0.1275
    var hallLat: Float = 51.507222
    var hallName: String = "Sheraton Helton Cairo Hotel"
    var hallAddress: String = "4ar3 b7r a3zam-gsr swes-giza"
    lazy var hallLocationCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(hallLat), longitude: CLLocationDegrees(hallLong))

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView1.delegate = self
        setupNavigationBar()
        if CLLocationCoordinate2DIsValid(hallLocationCoordinates) {
            setupComponent()
            centerMapOnLocation()
            addAnnotation()
        }else {
            self.show1buttonAlert(title: "Oops", message: "Invalid region", buttonTitle: "OK") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK-: Maps Functions
/******************************************************************************/
   @objc func centerMapOnLocation() {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0100, longitudeDelta: 0.0100)
        let region = MKCoordinateRegion.init(center: hallLocationCoordinates, span: span)
        mapView1.setRegion(region, animated: true)
    }
   
    func addAnnotation(){
        let hallAnnotation = CustomPointAnnotation()
        hallAnnotation.title = self.hallName
        hallAnnotation.subtitle = self.hallAddress
        hallAnnotation.coordinate = hallLocationCoordinates
        mapView1.addAnnotation(hallAnnotation)
        hallAnnotation.imageName = UIImage(named: "HallLocationICON777")
    }
    
    func openInExternalMaps(){
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: hallLocationCoordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: hallLocationCoordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.hallName
        mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomPointAnnotation else { return nil }
        let reuseId = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = UIImage(named: "HallLocationICON777")
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        annotationView!.canShowCallout = true
        return annotationView
    }
    
    
    // MARK-: Helper Methods
/******************************************************************************/
    @objc func directionsButtonAction(){
        openInExternalMaps()
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
    
    
    
    // MARK-: Setup Views
/******************************************************************************/
    func setupComponent(){
       guard let window = UIApplication.shared.keyWindow else { return }
        
       let bottomViewHeight = estimateFrameForTitleText(hallNameLabel.text!).height + estimateFrameForTitleText(hallAddressLabel.text!).height + 40 + window.safeAreaInsets.bottom
        
       view.addSubview(bottomView)
        bottomView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: bottomViewHeight))
        
        bottomView.addSubview(lineView)
        lineView.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: bottomView.trailingAnchor, size: CGSize(width: 0, height: 3))
        
        
        let leftViewWidth = 7*(view.frame.width/10)
        view.addSubview(leftView)
        leftView.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, size: CGSize(width: leftViewWidth, height: 0))
        
        leftView.addSubview(hallNameLabel)
        hallNameLabel.anchor(top: leftView.topAnchor, leading: leftView.leadingAnchor, bottom: nil, trailing: leftView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 10))
        
        leftView.addSubview(hallAddressLabel)
        hallAddressLabel.anchor(top: hallNameLabel.bottomAnchor, leading: leftView.leadingAnchor, bottom: nil, trailing: leftView.trailingAnchor, padding: .init(top: 7, left: 20, bottom: 0, right: 10))
        

        view.addSubview(rightView)
         rightView.anchor(top: bottomView.topAnchor, leading: leftView.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        rightView.addSubview(directionsButton)
        directionsButton.translatesAutoresizingMaskIntoConstraints = false
        directionsButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        directionsButton.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        directionsButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        directionsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(centerMapBackgroundView)
        centerMapBackgroundView.anchor(top: nil, leading: nil, bottom: bottomView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 15), size: CGSize(width: 50, height: 50))
        centerMapBackgroundView.layer.cornerRadius = 25
        
        view.addSubview(centerMapImage)
        centerMapImage.translatesAutoresizingMaskIntoConstraints = false
        centerMapImage.centerXAnchor.constraint(equalTo: centerMapBackgroundView.centerXAnchor).isActive = true
        centerMapImage.centerYAnchor.constraint(equalTo: centerMapBackgroundView.centerYAnchor).isActive = true
        centerMapImage.widthAnchor.constraint(equalToConstant: 27).isActive = true
        centerMapImage.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
    
    let bottomView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        iv.alpha = 0.9
        return iv
    }()
    let leftView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let rightView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let lineView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.mainAppPink()
        iv.alpha = 0.5
        return iv
    }()
    
    lazy var hallNameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = self.hallName
        titleL.font = UIFont.boldSystemFont(ofSize: 16)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    lazy var hallAddressLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = self.hallAddress
        titleL.font = UIFont.systemFont(ofSize: 13)
        titleL.textColor = UIColor.darkGray
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    lazy var directionsButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Directions", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.mainAppPink().cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(directionsButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var centerMapBackgroundView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(centerMapOnLocation))
        iv.addGestureRecognizer(tapGesture)
        iv.layer.borderWidth = 0.8
        iv.layer.borderColor = UIColor.lightGray.cgColor
        return iv
    }()
    lazy var centerMapImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "CenterMapICON777")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(centerMapOnLocation))
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    // MARK : Text size
    /*****************************************************************************************/
    fileprivate func estimateFrameForTitleText(_ text: String) -> CGRect {
        let width = (7*(view.frame.width/10))-40
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.boldSystemFont(ofSize: 15)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
    
}

