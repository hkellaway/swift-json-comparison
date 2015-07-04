//
//  RepoObjectMapper.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import ObjectMapper

class RepoObjectMapper: Mappable {
    var repoId: Int?
    var name: String?
    var desc: String?
    var url: NSURL?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        repoId  <- map["id"]
        name    <- map["name"]
        desc    <- map["description"]
        url     <- (map["html_url"], URLTransform())
    }
}

extension RepoObjectMapper: Printable {
    var description: String {
        return "RepoObjectMapper - repoId: \(repoId)\nname: \(name)\ndescription: \(desc)\nURL: \(url)"
    }
}