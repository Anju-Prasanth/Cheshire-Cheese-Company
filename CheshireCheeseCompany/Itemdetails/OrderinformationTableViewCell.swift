//
//  OrderinformationTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 22/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderinformationTableViewCell: UITableViewCell {
    @IBOutlet weak var lblitemordrd: UILabel!
    @IBOutlet weak var Outerview: UIView!

    @IBOutlet weak var btnorderinfrmtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
