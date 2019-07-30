//
//  Wishlistmap.swift
//  CheshireCheeseCompany
//
//  Created by apple on 14/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper



class whishlistresponse: Mappable {
    var status=String()
    var message=String()
    
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
       
    
        
    }
}
