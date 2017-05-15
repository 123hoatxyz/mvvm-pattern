//
//  MomentViewCtrl.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import UIKit

class MomentViewCtrl: BaseViewCtrl {
  // Outlet
  @IBOutlet weak var ibTable: UITableView!
  
  // ViewModel
  var viewModel: MomentViewModel! {
    didSet {
      viewModel.getPostCompleted = { [weak self] viewModel in
        guard let strongSelf = self else {
          return
        }
        strongSelf.ibTable.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = MomentViewModel.shared
    title = "Moments"
    setUpTable()
    if NetworkManager.shared.networkAvailable() == false {
      let alert = UIAlertController(title: nil, message: "Network not available", preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
    }
  }
  
  func setUpTable() {
    ibTable.register(MomentTableCell.self)
    ibTable.tableFooterView = UIView()
    ibTable.tableHeaderView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard viewModel.posts != nil else {
      viewModel.getAllPost()
      return
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK : - UITableView Datasource and Delegate

extension MomentViewCtrl: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard viewModel != nil else {
      return 0
    }
    guard viewModel.posts != nil else {
      return 0
    }
    return viewModel.posts!.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MomentTableCell
    cell.data(info: viewModel.posts?[indexPath.row], model: viewModel)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 363.0
  }
}
