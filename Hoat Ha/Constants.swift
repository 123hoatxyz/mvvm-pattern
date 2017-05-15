//
//  Constants.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

// MARK: - Generate a T type

enum Result<T> {
  case success(T)
  case failure(T)
}

// MARK: - Error Handling

enum SerializationError: Error {
  case missing(String)
  case invalid(String)
}

// MARK: - API information

struct API {
  // Base URL
  static let baseUrl               = "http://thedemoapp.herokuapp.com/"
  
  // Get all post
  static let post                  = "post"
  
  // Get like count with given post id
  static let likeCount       = "post/%d/likeCount"
  
  // Get comment count with given post id
  static let commentCount    = "post/%d/commentCount"
}
