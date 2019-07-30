//
//  OrderAddressTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 13/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var btnchckbox: UIButton!
    @IBOutlet weak var btnchangaadres: UIButton!
    @IBOutlet weak var lblgmail: UILabel!
    @IBOutlet weak var lblphnenum: UILabel!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
