//
//  ModelObjectMapper.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import ObjectMapper

class ModelObjectMapper: Mappable {
    var restroomId: Int?
    var name: String?
    
    // MARK: - Initialization
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // MARK: - Protocol conformance
    
    // MARK: Mappable
    
    func mapping(map: Map) {
        restroomId  <- map["id"]
        name        <- map["name"]
    }
}