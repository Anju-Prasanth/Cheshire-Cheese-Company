//
//  OrderaccountTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 18/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderaccountTableViewCell: UITableViewCell {
    @IBOutlet weak var btnorderdtails: UIButton!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblplacedon: UILabel!
    @IBOutlet weak var lblorderid: UILabel!
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
