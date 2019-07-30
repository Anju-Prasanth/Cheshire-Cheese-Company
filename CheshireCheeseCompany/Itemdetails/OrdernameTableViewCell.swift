//
//  OrdernameTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 22/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrdernameTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblrefunded: UILabel!
    @IBOutlet weak var lblcancld: UILabel!
    @IBOutlet weak var lblshipped: UILabel!
    @IBOutlet weak var lblordered: UILabel!
    @IBOutlet weak var lblitemname: UILabel!
    @IBOutlet weak var imageviewitem: UIImageView!
    @IBOutlet weak var lblitemsordered: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
