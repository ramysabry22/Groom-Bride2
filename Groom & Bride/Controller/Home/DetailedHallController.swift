import UIKit


class DetailedHallController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let cellID = "cellid"
    var detailedHall: Hall?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupHall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
    }
    func setupHall(){
        pageControll.numberOfPages = detailedHall?.hallImage.count ?? 1
        hallNameLabel.text = detailedHall?.hallName
        hallPriceLabel.text = (detailedHall?.hallPrice)!+" LE"
        hallDescriptionLabel.text = "Details: \n "+(detailedHall?.hallDescription)!
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.mainColor2()
  //      self.navigationController?.isNavigationBarHidden = true
        
        let firstLabel = UILabel()
        firstLabel.text = detailedHall?.hallName
        firstLabel.font = UIFont.systemFont(ofSize: 18)
        firstLabel.textAlignment = .center
        firstLabel.textColor = UIColor.black
        navigationItem.titleView = firstLabel
    }
    
    @objc func backButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK :- CollectionView
    /********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailedHall?.hallImage.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! detailedHallCell

        let stringUrl = "\(HelperData.sharedInstance.serverBasePath)/\(detailedHall!.hallImage[indexPath.row])"
        let encodedString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedString!)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: url, options: [.memoryCacheExpiration(.never)])
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0,height: 0.9)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControll.currentPage = pageNumber
        pageControll.updateCurrentPageDisplay()
    }
    // MARK :-  setup component
    /********************************************************************************************/
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        scrollView.addSubview(collectionView)
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        let top = CGFloat(topPadding ?? 0)
        collectionView.anchor(top: scrollView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: -top, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width, height: 3*(view.frame.height/6)))
        collectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        collectionView.register(detailedHallCell.self, forCellWithReuseIdentifier: cellID)
        
        
        scrollView.addSubview(backButton)
        backButton.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 0),size: CGSize(width: 30, height: 30))
        
        
        
        view.addSubview(pageControll)
        pageControll.anchor(top: nil, leading: collectionView.leadingAnchor, bottom: collectionView.bottomAnchor, trailing: collectionView.trailingAnchor,padding:  .init(top: 0, left: 0, bottom: collectionView.frame.height/20, right: 0))
        
        scrollView.addSubview(namePriceStackview)
        namePriceStackview.anchor(top: collectionView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: view.frame.width, height: 60))
        namePriceStackview.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        namePriceStackview.addArrangedSubview(hallNameLabel)
        hallNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hallNameLabel.leftAnchor.constraint(equalTo: namePriceStackview.leftAnchor,constant: 25).isActive = true
        hallNameLabel.rightAnchor.constraint(equalTo: namePriceStackview.rightAnchor,constant: -15).isActive = true
        namePriceStackview.addArrangedSubview(hallPriceLabel)
        hallPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        hallPriceLabel.leftAnchor.constraint(equalTo: namePriceStackview.leftAnchor,constant: 25).isActive = true
        hallPriceLabel.rightAnchor.constraint(equalTo: namePriceStackview.rightAnchor,constant: -15).isActive = true
        
        scrollView.addSubview(hallDescriptionLabel)
        hallDescriptionLabel.anchor(top: namePriceStackview.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0),size: CGSize(width: view.frame.width-30, height: 290))
        hallDescriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor.white
        v.isScrollEnabled = true
        v.isUserInteractionEnabled = true
      //  v.clipsToBounds = true
        v.bounces = false
        v.contentSize = CGSize(width: 0, height: 1000)
        return v
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    let pageControll: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.white
        pc.numberOfPages = 0
        pc.currentPageIndicatorTintColor = UIColor.darkGray
        pc.isUserInteractionEnabled = false
        return pc
    }()
    let hallNameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "  "
        titleL.font = UIFont.boldSystemFont(ofSize: 24)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let hallPriceLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "0 LE"
        titleL.font = UIFont.boldSystemFont(ofSize: 17)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let namePriceStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.leading
        sv.spacing = 3
        return sv
    }()
    let hallDescriptionLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "iiiijjjuiiuiuygyukgugjufjtyftr"
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .left
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    lazy var backButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("", for: .normal)
        button.frame.size = CGSize(width: 20, height: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "backButtonIOCN")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white.withAlphaComponent(0.3)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
}


