//
//  AllreviewTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 04/07/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Cosmos

class AllreviewTableViewCell: UITableViewCell {
    @IBOutlet weak var btnprdctreviewreadmore: UIButton!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var ratingvalue: CosmosView!
    @IBOutlet weak var ratingprice: CosmosView!
    @IBOutlet weak var ratingrtng: CosmosView!
    @IBOutlet weak var ratingquality: CosmosView!
    @IBOutlet weak var lblvalue: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblrating: UILabel!
    @IBOutlet weak var lblquality: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var Outerview: UIView!
     @IBOutlet weak var lblreviewheight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
