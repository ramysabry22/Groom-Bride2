
import UIKit

class OnBoardingScreens: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    
    let pages: [Page] = {
        let Page1 = Page(title: "Cloud Syncing", message: "It is a  long established fact that a reader will be", imageName: "image4")
        let Page2 = Page(title: "Explore Ideas", message: "It is a  long established fact that a reader will be", imageName: "image1")
        let Page3 = Page(title: "Vendor Listing", message: "It is a  long established fact that a reader will be", imageName: "image2")

        return [Page1, Page2, Page3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
        
        pageControll.numberOfPages = pages.count
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK :-  Main Methods
    /********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        //  cell.backgroundColor = UIColor.yellow
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControll.currentPage = pageNumber
        pageControll.updateCurrentPageDisplay()
        
        if pageNumber == 2 {
            showGetstartedButton()
        }
        else{
            hideGetstartedButton()
        }
        
    }
    @objc func buttonAction(sender: UIButton!) {
        UserDefaults.standard.set(true, forKey: "isFirstDownloadDone")
        UserDefaults.standard.synchronize()
        dismiss(animated: true, completion: nil)
    }
    func showGetstartedButton(){
        UIView.animate(withDuration: 0.4, animations: {
            self.getStartedButton.alpha = 1
            self.pageControll.alpha = 0
        }) { (Completed: Bool) in
            
        }
    }
    func hideGetstartedButton(){
        UIView.animate(withDuration: 0.1, animations: {
            self.getStartedButton.alpha = 0
            self.pageControll.alpha = 1
        }) { (Completed: Bool) in
            
        }
    }
    
    //   MARK :- Constrains
    /**********************************************************************************************/
    private func setupViews(){
        [collectionView,pageControll,getStartedButton].forEach { view.addSubview($0) }
        
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        pageControll.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding:  .init(top: 0, left: 0, bottom: 20, right: 0))
        
        getStartedButton.anchor(top: nil, leading: collectionView.leadingAnchor, bottom: collectionView.bottomAnchor, trailing: collectionView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 30, right: 30), size: CGSize(width: 0, height: 45))
    }
    
    
    
    
    
    // MARK :-  Setup Component
    /********************************************************************************************/
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
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.numberOfPages = 1
        pc.currentPageIndicatorTintColor = UIColor.mainColor2()
        pc.isUserInteractionEnabled = false
        return pc
    }()
    let getStartedButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainColor2()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.isHidden = false
        button.alpha = 0
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
}
