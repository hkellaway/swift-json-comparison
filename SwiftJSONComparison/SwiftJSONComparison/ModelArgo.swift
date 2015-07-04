//
//  ModelArgo.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Argo
import Runes

public struct ModelArgo {
    let restroomId: Int
    let name: String
}

extension ModelArgo: Decodable {
    static func create(restroomId: Int)(name: String) -> ModelArgo {
        return ModelArgo(restroomId: restroomId, name: name)
    }
    
    public static func decode(j: JSON) -> Decoded<ModelArgo> {
        return ModelArgo.create
            <^> j <| "id"
            <*> j <| "name"
    }
}
