//
//  BaseViewCtrl.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import UIKit

class BaseViewCtrl: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addNavigationWithBackAndCamera()
  }
  
  func addNavigationWithBackAndCamera() {
    let leftBar = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back(sender:)))
    leftBar.tintColor = UIColor.white
    navigationItem.leftBarButtonItem = leftBar
    
    let rightButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(callCamera(sender:)))
    rightButton.tintColor = UIColor.white
    navigationItem.rightBarButtonItem = rightButton
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension BaseViewCtrl {
  func back(sender: AnyObject) {
    
  }
  
  func callCamera(sender: AnyObject) {
    
  }
}
