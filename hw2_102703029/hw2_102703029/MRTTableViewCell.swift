//
//  MRTTableViewCell.swift
//  hw2_102703029
//
//  Created by 盧與明 on 2016/5/3.
//  Copyright © 2016年 YuMing_Lu. All rights reserved.
//

import UIKit

class MRTTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lineNumStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
