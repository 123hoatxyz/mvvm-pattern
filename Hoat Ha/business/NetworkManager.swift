//
//  NetworkManager.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import Foundation
import SystemConfiguration

final class NetworkManager {
  
  static let shared = NetworkManager()
  private init() {}
  
  func GETMethod(endpoint: String, response: @escaping (_ dict: [String: Any]?) -> Void) {
    //print("Read from Network")
    let url = URL(string: API.baseUrl + endpoint)
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "GET"
    
    let fileName = String.md5Hex(string: endpoint)
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
      guard error == nil else {
        response(nil)
        return
      }
      guard let newData = data else {
        response(nil)
        return
      }
      let dict = try? JSONSerialization.jsonObject(with: newData, options: [])
      response(dict as? [String : Any])
      LocalStore.shared.write(data: newData, atEndpoint: endpoint, fileName: fileName)
    }
    
    task.resume()
  }
  
  func download(url: URL?, response: @escaping (_ data: Data?) -> Void) {
    guard let newUrl = url else {
      response(nil)
      return
    }
    
    var urlRequest = URLRequest(url: newUrl)
    urlRequest.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlRes, error) in
      guard error == nil else {
        response(nil)
        return
      }
      response(data)
    }
    
    task.resume()
  }
  
  func networkAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
      }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
  }
}
