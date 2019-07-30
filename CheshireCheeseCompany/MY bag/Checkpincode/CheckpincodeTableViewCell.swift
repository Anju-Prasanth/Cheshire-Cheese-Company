//
//  CheckpincodeTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class CheckpincodeTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var btncheck: UIButton!
    @IBOutlet weak var txtfldpincode: UITextField!
    @IBOutlet weak var lblchckpincode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let myColor = UIColor.lightGray
        txtfldpincode.layer.borderColor = myColor.cgColor
        txtfldpincode.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
