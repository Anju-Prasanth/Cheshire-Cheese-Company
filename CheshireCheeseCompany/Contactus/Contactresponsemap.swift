//
//  Contactresponsemap.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper



class Contactresponse: Mappable {
    var status:String?
    var message:String?
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        
        
        
    }
}
