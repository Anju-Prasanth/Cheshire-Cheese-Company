//
//  ProductdetailTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 03/07/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ProductdetailTableViewCell: UITableViewCell {

    @IBOutlet weak var viewouterproductdetail: UIView!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var btndetailreadmore: UIButton!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lbldetailheight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
