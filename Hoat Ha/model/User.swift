//
//  User.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

struct User {
  var id: Int?
  var fullName: String?
  var mobileNo: String?
  var dob: Date?
  var imageURL: URL?
}

extension User {
  init(json: [String: Any]) throws {
    
    guard let id = json["_id"] as? Int else {
      throw SerializationError.missing("_id")
    }
    guard let mobileNo = json["mobileNo"] as? String else {
      throw SerializationError.missing("mobileNo")
    }
    guard let dob = json["dob"] as? String else {
      throw SerializationError.missing("dob")
    }
    guard let imageURL = json["imageURL"] as? String else {
      throw SerializationError.missing("imageURL")
    }
    guard let fullName = json["fullName"] as? String else {
      throw SerializationError.missing("user")
    }
    guard URL.init(string: imageURL) != nil else {
      throw SerializationError.invalid("imageURL")
    }
    self.id = id
    self.mobileNo = mobileNo
    self.imageURL = URL(string: imageURL)
    self.dob = Date.date(from: dob)
    self.fullName = fullName
  }
}

extension User: CustomStringConvertible {
  var description: String {
    return "[\(String(describing: self.id)), \(String(describing: self.dob))]"
  }
}
