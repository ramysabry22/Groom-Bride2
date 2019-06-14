//
//  SearchController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/13/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class SearchController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
       
        self.collectionView1.register(UINib(nibName: "HallCell", bundle: nil), forCellWithReuseIdentifier: "HallCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
    }
    
    // MARK:- CollectionView
/*********************************************************************************/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HallCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "HallCell", for: indexPath) as! HallCell
        
        cell.backgroundColor = UIColor.white
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let cellHeight = max(270, view.frame.height/3)
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    @IBAction func SearchButtonTapped(_ sender: UIButton) {
        
        
        
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
       navigationController?.popViewController(animated: true)
    }

}
