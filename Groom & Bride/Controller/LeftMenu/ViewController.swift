//
//  ViewController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 5/1/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class LoginComponentNavigationController: UINavigationController {
   
   weak var delegateee: HomeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationController?.isNavigationBarHidden = true
       view.backgroundColor = UIColor.white
        let homeController = SignInController() // was loginstartscreen in the past
        viewControllers = [homeController]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        delegateee?.didBackButtonPressed()
       navigationController?.isNavigationBarHidden = false
    }
}
