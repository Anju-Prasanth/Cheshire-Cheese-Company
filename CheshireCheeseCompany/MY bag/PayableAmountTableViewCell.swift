//
//  PayableAmountTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class PayableAmountTableViewCell: UITableViewCell {

    @IBOutlet weak var lbldiscountamount: UILabel!
    @IBOutlet weak var lbldiscount: UILabel!
    @IBOutlet weak var lbltotalpay: UILabel!
    @IBOutlet weak var lblstrngpayableamnt: UILabel!
    @IBOutlet weak var lblsumtot: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
