//
//  NobillingadrsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 23/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class NobillingadrsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnaddars: UIButton!
    @IBOutlet weak var lblnoadrs: UILabel!
    @IBOutlet weak var lblnblngadrs: UILabel!
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
