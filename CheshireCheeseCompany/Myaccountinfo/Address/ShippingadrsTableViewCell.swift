//
//  ShippingadrsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 11/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ShippingadrsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblphonenumbr: UILabel!
    @IBOutlet weak var lblregion: UILabel!
    @IBOutlet weak var btneditadrs: UIButton!
    @IBOutlet weak var lbladrs3: UILabel!
    @IBOutlet weak var lbladrs2: UILabel!
    @IBOutlet weak var lbladrs1: UILabel!
    @IBOutlet weak var lblshpngadrs: UILabel!
    @IBOutlet weak var Outerview: UIView!
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
