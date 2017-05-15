//
//  Product.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

struct Post {
  var id: Int?
  var message: String?
  var postedAt: Date?
  var imageURL: URL?
  var user: User?
}

extension Post {
  init(json: [String: Any]) throws {
    
    guard let id = json["_id"] as? Int else {
      throw SerializationError.missing("_id")
    }
    guard let message = json["message"] as? String else {
      throw SerializationError.missing("message")
    }
    guard let postedAt = json["postedAt"] as? String else {
      throw SerializationError.missing("postedAt")
    }
    guard let imageURL = json["imageURL"] as? String else {
      throw SerializationError.missing("imageURL")
    }
    guard let userJSON = json["user"] as? [String: Any] else {
      throw SerializationError.missing("user")
    }
    guard URL.init(string: imageURL) != nil else {
      throw SerializationError.invalid("imageURL")
    }
    self.id = id
    self.message = message
    self.imageURL = URL(string: imageURL)
    self.postedAt = Date.date(from: postedAt)
    self.user = try? User(json: userJSON)
  }
}

extension Post: CustomStringConvertible {
  var description: String {
    return "[id:\(String(describing: self.id)), postAt:\(String(describing: self.postedAt))]"
  }
}
