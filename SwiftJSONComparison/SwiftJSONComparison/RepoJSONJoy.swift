//
//  RepoJSONJoy.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import JSONJoy

struct RepoJSONJoy: JSONJoy {
    let repoId: Int
    let name: String
    let desc: String?
    var url: NSURL?
    
    init(_ decoder: JSONDecoder) {
        repoId = decoder["id"].integer!
        name = decoder["name"].string!
        desc = decoder["description"].string
        url = urlFromString(decoder["html_url"].string!)!
    }
    
    private func urlFromString(str: String) -> NSURL? {
        return NSURL(string: str)
    }
}

extension RepoJSONJoy: Printable {
    var description: String {
        return "RepoJSONJoy - repoId: \(repoId)\nname: \(name)\ndescription: \(desc)\nURL: \(url)"
    }
}