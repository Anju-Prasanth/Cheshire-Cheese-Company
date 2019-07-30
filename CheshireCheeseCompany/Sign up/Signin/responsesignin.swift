//
//  responsesignin.swift
//  CheshireCheeseCompany
//
//  Created by apple on 05/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class responsesignin: Mappable {
    var CustomerData:[String:AnyObject]!
    var entity_id=String()
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        CustomerData <- map["CustomerData"]
        entity_id <- map["CustomerData.entity_id"]
        
        
    }
}

