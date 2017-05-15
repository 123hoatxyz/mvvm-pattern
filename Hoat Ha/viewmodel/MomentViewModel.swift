//
//  MomentViewModel.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation

protocol MomentProtocol {
  var posts: [Post]? { get }
  var getPostCompleted: (()->())? { get }
  var getPostFailed: (()->())? { get }
}

class MomentViewModel: MomentProtocol {
  class var shared: MomentViewModel {
    struct Static {
      static let instance : MomentViewModel = MomentViewModel()
    }
    return Static.instance
  }
  var posts: [Post]? {
    didSet{
      getPostCompleted?()
    }
  }
  var getPostCompleted: (() -> ())?
  var getPostFailed: (() -> ())?
  
  // get all post of moment
  
  func getAllPost() {
    MomentBusinessCtrl.allPosts { [weak self] res in
      DispatchQueue.main.async {
        guard let strongSelf = self else {
          return
        }
        switch res {
        case .failure(_):
          break
        case .success(let data):
          strongSelf.posts = data
          break
        }
      }
    }
  }
  
  // get  the like count from post id
  
  func likeCount(id: Int, count: @escaping (Int) -> Void) {
    MomentBusinessCtrl.likeCount(postId: id) { res in
      DispatchQueue.main.async {
        switch res {
        case .failure(_):
          count(-1)
          break
        case .success(let data):
          count(data)
          break
        }
      }
    }
  }
  
  // get the comment count from post id
  func commentCount(id: Int, count: @escaping (Int) -> Void) {
    MomentBusinessCtrl.commentCount(postId: id) { res in
      DispatchQueue.main.async {
        switch res {
        case .failure(_):
          count(-1)
          break
        case .success(let data):
          count(data)
          break
        }
      }
    }
  }
}
