//
//  Movie.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit

import ObjectMapper

struct Movie: Mappable {
    var title: String?
    var overview: String?
    var poster_path: String?
    var original_language:String?
    var release_date:String?
    var id:Int?
    var key:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["original_title"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        original_language <- map["original_language"]
        id <- map["id"]
        key <- map["key"]
    }
}
