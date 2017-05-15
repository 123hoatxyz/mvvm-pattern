//
//  MomentTableCell.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/8/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import UIKit

class MomentTableCell: BaseTableCell {
    
  weak var viewModel: MomentViewModel!
  @IBOutlet weak var ibAvatar: UIImageView!
  @IBOutlet weak var ibFullName: UILabel!
  @IBOutlet weak var ibPostAt: UILabel!
  @IBOutlet weak var ibImagePost: UIImageView!
  @IBOutlet weak var ibMessage: UILabel!
  @IBOutlet weak var ibLikeNumber: UILabel!
  @IBOutlet weak var ibCommentNumber: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    ibAvatar.addCircle(size: 50)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

// MARK: - event

extension MomentTableCell {
  @IBAction func actionLike(_ sender: Any) {
    
  }

  @IBAction func actionComment(_ sender: Any) {
  
  }
  
  func data(info: Post?, model: MomentViewModel!) {
    guard info != nil else {
      return
    }
    viewModel = model
    ibFullName.text = info?.user?.fullName
    ibMessage.text = info?.message
    ibPostAt.text = Date.timeAgo(dateComponent: Date.dateComponent(startDate: info!.postedAt!, endDate: Date()))
    
    // download image profile and post
    
    ImageManager.shared.dowloadImage(atURL: info?.imageURL) { [weak self] data in
      guard let strongSelf = self else { return }
      if data != nil {
        strongSelf.ibImagePost?.image = UIImage(data: data!)
      }
    }
    
    ImageManager.shared.dowloadImage(atURL: info?.user?.imageURL) { [weak self] data in
      guard let strongSelf = self else { return }
      if data != nil {
        strongSelf.ibAvatar?.image = UIImage(data: data!)
      }
    }
    
    // get like and comment count
    
    guard viewModel != nil else {
      return
    }
    viewModel.likeCount(id: info!.id!) { [weak self] num in
      guard let strongSelf = self else { return }
      if num != -1 {
        strongSelf.ibLikeNumber.text = num > 1 ? "\(num) Likes" : "\(num) Like"
      }
    }
    
    viewModel.commentCount(id: info!.id!) { [weak self] num in
      guard let strongSelf = self else { return }
      if num != -1 {
        strongSelf.ibCommentNumber.text = num > 1 ? "\(num) Comments" : "\(num) Comment"
      }
    }
  }
}
