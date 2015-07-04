//
//  ModelJSONJoy.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import JSONJoy

struct ModelJSONJoy: JSONJoy {
    let restroomId: Int?
    let name: String?
    
    init() {
        
    }
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