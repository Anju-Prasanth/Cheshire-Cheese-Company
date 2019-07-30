//
//  ItemdetailsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ItemdetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtfldqty: UITextField!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var btnwishlist: UIButton!
    
    @IBOutlet weak var btnclose: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
