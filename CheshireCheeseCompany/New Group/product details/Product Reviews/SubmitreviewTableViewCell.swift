//
//  SubmitreviewTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 27/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Cosmos

class SubmitreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var viewoutersubmitreview: UIView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var ratingqty: CosmosView!
    @IBOutlet weak var ratingrtng: CosmosView!
    @IBOutlet weak var ratingprice: CosmosView!
    @IBOutlet weak var ratingvalue: CosmosView!
    @IBOutlet weak var txtviewnickname: UITextField!
    @IBOutlet weak var txtviewsummary: UITextField!
    @IBOutlet weak var lblreview: UILabel!
    @IBOutlet weak var txtviewreview: UITextView!
    @IBOutlet weak var btnsubmit: UIButton!
   
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnsubmit.layer.cornerRadius=5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
