//
//  MomentBusinessCtrl.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

class MomentBusinessCtrl: NSObject {
  static let background = DispatchQueue(label: "run.hockey.hoatha", qos: .background,
                                        attributes: .concurrent,
                                        autoreleaseFrequency: .inherit, target: nil)
  
  // MARK: - All Post
  
  static func allPosts(handler resultHandler:@escaping (Result<[Post]?>) -> Void) {
    let fileName = String.md5Hex(string: API.post)
    if let data = LocalStore.shared.read(atPath: fileName) {
      //print("Read from Local")
      let dict = try? JSONSerialization.jsonObject(with: data, options: [])
      allPostsResponse(dict: dict as? [String: Any], resultHandler: resultHandler)
    }
    
    background.async {
      NetworkManager.shared.GETMethod(endpoint: API.post, response: { dict in
        allPostsResponse(dict: dict, resultHandler: resultHandler)
      })
    }
  }
  
  static func allPostsResponse(dict: [String: Any]?, resultHandler:@escaping (Result<[Post]?>) -> Void) {
    guard dict != nil else {
      resultHandler(Result.failure(nil))
      return
    }
    var posts = [Post]()
    if let data = dict!["data"] as? [Any] {
      for item in data {
        let post = try? Post(json: item as! [String: Any])
        if post != nil {
          posts.append(post!)
        }
      }
    }
    resultHandler(Result.success(posts))
  }
  
  // MARK: - Like Count
  
  static func likeCount(postId: Int, resultHandler:@escaping (Result<Int>) -> Void) {
    let endpoint = String(format: API.likeCount, postId)
    let fileName = String.md5Hex(string: endpoint)
    
    if let data = LocalStore.shared.read(atPath: fileName) {
      //print("Read from Local")
      let dict = try? JSONSerialization.jsonObject(with: data, options: [])
      countResponse(dict: dict as? [String: Any], resultHandler: resultHandler)
    }
    
    background.async {
      NetworkManager.shared.GETMethod(endpoint: endpoint, response: { dict in
        countResponse(dict: dict, resultHandler: resultHandler)
      })
    }
  }
  
  static func countResponse(dict: [String: Any]?, resultHandler:@escaping (Result<Int>) -> Void) {
    guard dict != nil else {
      resultHandler(Result.failure(0))
      return
    }
    guard let num = dict!["data"] as? Int else {
      resultHandler(Result.failure(0))
      return
    }
    resultHandler(Result.success(num))
  }
  
  // MARK: - Comment Count
  
  static func commentCount(postId: Int, resultHandler:@escaping (Result<Int>) -> Void) {
    let endpoint = String(format: API.commentCount, postId)
    let fileName = String.md5Hex(string: endpoint)
    
    if let data = LocalStore.shared.read(atPath: fileName) {
      //print("Read from Local")
      let dict = try? JSONSerialization.jsonObject(with: data, options: [])
      countResponse(dict: dict as? [String: Any], resultHandler: resultHandler)
    }
    background.async {
      NetworkManager.shared.GETMethod(endpoint: endpoint, response: { dict in
        countResponse(dict: dict, resultHandler: resultHandler)
      })
    }
  }
}
