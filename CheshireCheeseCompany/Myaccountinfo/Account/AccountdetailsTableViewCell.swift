//
//  AccountdetailsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 09/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class AccountdetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnchangeaprofileinfo: UIButton!
    @IBOutlet weak var btnchangepassword: UIButton!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblname: UILabel!
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
