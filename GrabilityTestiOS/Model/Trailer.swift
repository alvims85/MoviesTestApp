//
//  Trailer.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import ObjectMapper

struct Trailer: Mappable {

    var id:Int?
    var key:String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
    }
    
}





