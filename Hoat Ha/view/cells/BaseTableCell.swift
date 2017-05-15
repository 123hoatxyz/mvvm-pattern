//
//  BaseTableCell.swift
//  Hoat Ha
//
//  Created by Brian Ha on 5/9/17.
//  Copyright © 2017 HocKey Run. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension BaseTableCell: ReusableView { }

extension BaseTableCell: NibLoadableView { }
