//
//  AllshipmentTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 07/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class AllshipmentTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblqtyshipped: UILabel!
    @IBOutlet weak var lblsku: UILabel!
    @IBOutlet weak var lblorderid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
