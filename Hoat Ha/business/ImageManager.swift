//
//  ImageManager.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/10/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation
import UIKit

final class ImageManager {
  static let backgroundQueue = DispatchQueue(label: "run.hockey.download", qos: .background,
                                             attributes: DispatchQueue.Attributes.concurrent,
                                             autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
  static let shared = ImageManager()
  private init() {}
  func dowloadImage(atURL: URL?, image: @escaping (Data?) -> Void) {
    ImageManager.backgroundQueue.async {
      NetworkManager.shared.download(url: atURL) { data in
        DispatchQueue.main.async {
          image(data)
        }
      }
    }
  }
}
