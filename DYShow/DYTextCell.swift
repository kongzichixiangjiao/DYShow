//
//  DYTextCell.swift
//  DYShow
//
//  Created by 侯佳男 on 2018/7/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class DYTextCell: UITableViewCell {

    static let identifier = "DYTextCell"
    static let height: CGFloat = 30
    
    @IBOutlet weak var myTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
