
import UIKit

class OnBoardingScreens: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView1: UICollectionView!
    let cellId = "cellId"
    
    let pages: [Page] = {
        let Page1 = Page(title: "Welcome", message: "It is a  long established fact that a reader will be", imageName: "OnBoardingImage1777")
        let Page2 = Page(title: "Wedding halls", message: "It is a  long established fact that a reader will be", imageName: "OnBoardingImage2777")
        let Page3 = Page(title: "Add to favorite", message: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standa", imageName: "OnBoardingImage3777")

        return [Page1, Page2, Page3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView1.dataSource = self
        collectionView1.delegate = self
        setupViews()
        pageControll.numberOfPages = pages.count
    }
    
    // MARK :-  Main Methods
/********************************************************************************************/
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        cell.backgroundColor = UIColor.white
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.collectionView1.frame.width, height: self.collectionView1.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
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
//        UserDefaults.standard.set(true, forKey: "isFirstDownloadDone")
//        UserDefaults.standard.synchronize()
        
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "signInScreen") as! SignInController
        let loginComponent = UINavigationController(rootViewController: controller)
        loginComponent.isNavigationBarHidden = true
        present(loginComponent, animated: true, completion: nil)
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
    
   
    // MARK :-  Setup Component
/********************************************************************************************/
    private func setupViews(){
        [pageControll,getStartedButton].forEach { view.addSubview($0) }
        
        let bottomPadding = collectionView1.frame.height/12
        
        pageControll.anchor(top: nil, leading: collectionView1.leadingAnchor, bottom: collectionView1.bottomAnchor, trailing: collectionView1.trailingAnchor,padding:  .init(top: 0, left: 0, bottom: bottomPadding, right: 0))
        
        getStartedButton.anchor(top: nil, leading: collectionView1.leadingAnchor, bottom: collectionView1.bottomAnchor, trailing: collectionView1.trailingAnchor, padding: .init(top: 0, left: 30, bottom: bottomPadding, right: 30), size: CGSize(width: 0, height: 45))
    }
    let pageControll: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.numberOfPages = 1
        pc.currentPageIndicatorTintColor = UIColor.mainAppPink()
        pc.isUserInteractionEnabled = false
        return pc
    }()
    lazy var getStartedButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.frame.size = CGSize(width: 80, height: 100)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.mainAppPink()
        button.setTitleColor(UIColor.white, for: .normal)
        button.isHidden = false
        button.alpha = 0
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
}
