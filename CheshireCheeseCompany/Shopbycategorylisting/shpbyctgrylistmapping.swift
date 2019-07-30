//
//  shpbyctgrylistmapping.swift
//  CheshireCheeseCompany
//
//  Created by apple on 26/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Shopctgrylisting: Mappable {
    var categories:[String:AnyObject]!
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        categories <- map["categories"]
        
        
    }
}
