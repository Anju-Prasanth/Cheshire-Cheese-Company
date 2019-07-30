//
//  PromocodeTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class PromocodeTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var btnapply: UIButton!
    @IBOutlet weak var txtpromo: UITextField!
    @IBOutlet weak var lblpromocode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
