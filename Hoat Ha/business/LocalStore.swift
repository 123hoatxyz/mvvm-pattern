//
//  LocalStore.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/9/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import UIKit

final class LocalStore {
  // shared
  static let shared = LocalStore()
  private init() {}
  
  let documentURL: URL? = {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
  }()
  
  func isExists(atPath: String) -> Bool {
    if FileManager.default.fileExists(atPath: atPath) {
      return true
    }
    return false
  }
  
  func appendURL(atPath: String) -> URL? {
    guard let url = documentURL else {
      return nil
    }
    return url.appendingPathComponent(atPath)
  }
  
  func write(data out: Data, atEndpoint: String, fileName: String) {
    guard var url = documentURL else {
      return
    }
    url = url.appendingPathComponent(fileName)
    do {
      try out.write(to: url, options: .atomic)
    } catch {
      print("error save a file")
    }
  }
  
  func read(atPath: String) -> Data? {
    guard var url = documentURL else {
      return nil
    }
    url = url.appendingPathComponent(atPath)
    guard isExists(atPath: url.path) else {
      return nil
    }
    do {
      return try Data(contentsOf: url)
    }
    catch {
      print("error read a file")
    }
    return nil
  }
}
