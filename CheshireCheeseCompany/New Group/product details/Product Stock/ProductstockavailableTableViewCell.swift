//
//  ProductstockavailableTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 11/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ProductstockavailableTableViewCell: UITableViewCell {

    @IBOutlet weak var viewouterproductstock: UIView!
    @IBOutlet weak var btndeliveryreadmore: UIButton!
    @IBOutlet weak var lblestimateddeliveryheight: NSLayoutConstraint!
    @IBOutlet weak var stockavailableheight: NSLayoutConstraint!
    @IBOutlet weak var lbldscrptn: UILabel!
    @IBOutlet weak var lblstockavailable: UILabel!
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
