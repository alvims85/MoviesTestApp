//
//  Tv.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import ObjectMapper

struct TvSerie: Mappable {

    var id:Int?
    var name:String?
    var overview:String?
    var posterPath:String?
    var firstAirDate:String?
    var originalName:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        originalName <- map["original_name"]
        firstAirDate <- map["first_air_date"]
    }
}





