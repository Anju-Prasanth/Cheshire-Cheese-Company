//
//  OrderpriceTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 22/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderpriceTableViewCell: UITableViewCell {

    @IBOutlet weak var lbldiscount: UILabel!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lbltax: UILabel!
    @IBOutlet weak var lblshpnghndlng: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
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
