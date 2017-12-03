//
//  ViewController.swift
//  UITextView_Header
//
//  Created by 🦊Tomoya Hirano on 12/03/2017.
//  Copyright (c) 2017 🦊Tomoya Hirano. All rights reserved.
//

import UIKit
import UITextView_Header

class ViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    let label = UILabel()
    label.text = "header text"
    textView.headerView = label
  }
}

