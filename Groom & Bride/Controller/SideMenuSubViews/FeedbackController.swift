//
//  FeedbackController.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 6/12/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class FeedbackController2: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var textViewPlaceHolderLabel: UILabel!
    @IBOutlet weak var textView1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        textView1.delegate = self
        textView1.layer.borderWidth = 1
        textView1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        textView1.layer.cornerRadius = 6
    }
    

    @IBAction func FeedbackButtonAction(_ sender: UIButton) {
        
    }
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceHolderLabel.isHidden = !textView1.text.isEmpty
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F6F6F6")
        navigationController?.isNavigationBarHidden = false
      
        navigationItem.title = "Feedback"
        
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
