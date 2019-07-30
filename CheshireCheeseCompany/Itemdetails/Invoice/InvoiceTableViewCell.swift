//
//  InvoiceTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 25/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var lbldscnt: UILabel!
   
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lbltax: UILabel!
    @IBOutlet weak var lblshipping: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblordername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
