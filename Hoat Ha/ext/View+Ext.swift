//
//  View+Ext.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/9/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NibLoadableView
protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}

// MARK: - ReusableView
protocol ReusableView: class {}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

// MARK: - UITableView

extension UITableView {

  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    let Nib = UINib(nibName: T.nibName, bundle: nil)
    register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
}

// MARK: - UIView

extension UIView {
  func addCircle(size: CGFloat) {
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = size / 2.0
    self.clipsToBounds = true
  }
}
