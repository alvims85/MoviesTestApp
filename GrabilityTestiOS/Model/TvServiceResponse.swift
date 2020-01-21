//
//  TvServiceResponse.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import Foundation
import ObjectMapper

struct TvServiceResponse: Mappable {

    var totalPages: Int?
         var totalResults:Int?
         var success:Bool?
         var results: [TvSerie]?
         
         init?(map: Map){
             
         }
         mutating func mapping(map: Map) {
             totalPages <- map["total_pages"]
             totalResults <- map["total_results"]
             results <- map["results"]
         }
}
