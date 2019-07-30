//
//  Homeslidermapping.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 15/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class responsetest: Mappable {
    var bannerslider:[String:AnyObject]!
    var title=String()
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        bannerslider <- map["bannerslider"]
        title <- map["bannerslider.title"]
        
        
    }
}

