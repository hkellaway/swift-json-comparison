//
//  ModelJSONJoy.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import JSONJoy

struct ModelsJSONJoy : JSONJoy {
    var restrooms: [ModelJSONJoy]?

    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let decoders = decoder.array {
            restrooms = [ModelJSONJoy]()
            
            for restroomDecoder in decoders {
                restrooms?.append(ModelJSONJoy(restroomDecoder))
            }
        }
    }
}

struct ModelJSONJoy: JSONJoy {
    let restroomId: Int?
    let name: String?
    
    init(_ decoder: JSONDecoder) {
        restroomId = decoder["id"].integer
        name = decoder["name"].string
    }
}

extension ModelJSONJoy: Printable {
    var description: String {
        return "ModelJSONJoy - restroomId: \(restroomId)\nname: \(name)"
    }
}