//
//  HomeControllerX.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 8/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class HomeVIewControllerX: UIViewController, HomeViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
   
    var presenter: HomePresenterProtocol?

    @IBOutlet weak var collectionView1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchIconImage: UIImageView!
    @IBOutlet weak var HomeLabel: UILabel!
    @IBOutlet weak var topComponentView: UIView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionsVIews()
        presenter?.fetchData(currentCell: 0)
    }
    private func setupCollectionsVIews(){
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.prefetchDataSource = self
         self.collectionView2.register(UINib(nibName: "HallCell", bundle: nil), forCellWithReuseIdentifier: "HallCell")
        self.collectionView1.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
    }
    
    func dataRecived() {
        collectionView2.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView2 { return presenter?.hallsNumberOfRows ?? 0 }
        else { return  presenter?.categoriesNumberOfRows ?? 0 }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView2 {
            let cell: HallCell = collectionView2.dequeueReusableCell(withReuseIdentifier: "HallCell", for: indexPath) as! HallCell
            
            presenter?.configureHallCell(cell: cell, indexpath: indexPath)
            cell.makeShadow(cornerRadius: 8)
            return cell
        }else {
            let cell: FilterCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            
            presenter?.configureFilterCell(cell: cell, indexpath: indexPath)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView2 {
//            let cellHeight = max(270, view.frame.height/3)
//            return CGSize(width: view.frame.width-22, height: cellHeight)
        }else {
//            let cellTitle = categories[indexPath.row].name!
//            let cellWidth = estimateFrameForSubTitleText(cellTitle).width + 15 + view.frame.width/8
//            return CGSize(width: cellWidth, height: collectionView1.frame.height)
        }
        
        
        let cellHeight = max(270, view.frame.height/3)
        return CGSize(width: view.frame.width-22, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionView2 { return 20 }
        else { return 0 }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView1 {
          //  fetchHalls(index: indexPath.row)
        }
        else if collectionView == collectionView2 {
//            let selectedHall = allHalls[indexPath.row]
//            if selectedHall.hallImage.isEmpty == true || selectedHall.hallImage.count <= 0 {
//                self.show1buttonAlert(title: "Oops", message: "Sorry, hall info not available, contact us to report issue", buttonTitle: "OK") {
//
//                }
//                return
//            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "DetailedHallController") as! DetailedHallController
//            controller.detailedHall = allHalls[indexPath.row]
//            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let window = UIApplication.shared.keyWindow else { return }
        
//        if velocity.y > 0 && notScrolling { // hide
//            notScrolling = false
//            isNavBarHidden = true
//            self.collectionView2TopConstraint.constant = 50 //
//            self.collectionView1TopConstraint.constant = 5
//            self.topViewTopConstraint.constant = -110 - window.safeAreaInsets.top
//
//            UIView.animate(withDuration: 0.15, animations: {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.view.layoutIfNeeded()
//            }, completion: { (finished) in
//                self.notScrolling = true
//            })
//        }
//        else if velocity.y < 0.0  && notScrolling { // show
//            notScrolling = false
//            isNavBarHidden = false
//            self.collectionView2TopConstraint.constant = 153
//            self.collectionView1TopConstraint.constant = 104
//            self.topViewTopConstraint.constant = 5
//
//            UIView.animate(withDuration: 0.2, animations: {
//                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                self.view.layoutIfNeeded()
//            }, completion: { (finished) in
//                self.notScrolling = true
//            })
//        }
//        else {
//
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if collectionView == collectionView2 {
            let currentIndex = (indexPaths.last?.row)! + 5
            presenter?.fetchData(currentCell: currentIndex)
        }
    }
    
    
    
}
