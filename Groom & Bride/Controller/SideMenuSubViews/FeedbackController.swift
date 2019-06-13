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
}
