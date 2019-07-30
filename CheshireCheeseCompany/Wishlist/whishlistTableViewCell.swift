//
//  whishlistTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 15/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class whishlistTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var btnclose: UIButton!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var btnbuynow: UIButton!
    @IBOutlet weak var lblitemname: UILabel!
    @IBOutlet weak var imageviewwhishlistitem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
