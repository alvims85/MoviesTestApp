//
//  TrailersServiceResponse.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import ObjectMapper

struct TrailersServiceResponse: Mappable {

    var results: [Trailer]?
    var id: Int?
          init?(map: Map){
          }
          mutating func mapping(map: Map) {
              results <- map["results"]
              id <- map["id"]
          }
}



