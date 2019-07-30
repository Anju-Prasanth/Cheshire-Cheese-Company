//
//  ShipmentdetailsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 07/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ShipmentdetailsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var shpmntbtninvoice: UIButton!
    @IBOutlet weak var btnordershipmnt: UIButton!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
