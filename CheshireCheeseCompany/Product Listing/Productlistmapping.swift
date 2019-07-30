//
//  Productlistmapping.swift
//  CheshireCheeseCompany
//
//  Created by apple on 26/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class productlisting: Mappable {
    var products:[AnyObject]!
    
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        products <- map["products"]
       
        
        
    }
}
class product1: Mappable {
  
    var name=String()
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
      
        name <- map["name"]
        
        
    }
}


