//
//  ViewController.swift
//  UITextView_Header
//
//  Created by 🦊Tomoya Hirano on 12/03/2017.
//  Copyright (c) 2017 🦊Tomoya Hirano. All rights reserved.
//

import UIKit
import UITextView_Header

class ViewController: UIViewController, UITextViewDelegate {
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    textView.alwaysBounceVertical = true
    textView.delegate = self
    
    let label = UILabel()
    label.text = "header text"
    textView.headerView = label
    textView.headerViewSpace = 0
    
    let label2 = UILabel()
    label2.text = "footer text"
    textView.footerView = label2
    textView.footerViewSpace = 0
    
    textView.placeholder = NSAttributedString(string: "いまなにしてる？")
  }
  
  func textViewDidChange(_ textView: UITextView) {
    textView.textViewDidChange()
  }
}

