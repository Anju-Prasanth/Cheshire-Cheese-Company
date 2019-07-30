//
//  ProductDescriptionTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 11/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var txtfldouter: UITextField!
    @IBOutlet weak var btnreviews: UIButton!
    @IBOutlet weak var btndelivery: UIButton!
    @IBOutlet weak var btndetails: UIButton!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblproductdetails: UILabel!
    @IBOutlet weak var lblprdctdscrptn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
