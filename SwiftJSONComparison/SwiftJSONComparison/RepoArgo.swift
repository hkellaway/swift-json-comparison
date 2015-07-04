//
//  RepoArgo.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Argo
import Runes

struct RepoArgo {
    let repoId: Int
    let name: String
    let desc: String?
    let url: NSURL
}

extension RepoArgo: Decodable {
    static func create(repoId: Int)(name: String)(desc: String?)(urlString: String) -> RepoArgo {
        
        return RepoArgo(repoId: repoId, name: name, desc: desc, url: urlFromString(urlString)!)
    }
    
    static func decode(j: JSON) -> Decoded<RepoArgo> {
        return RepoArgo.create
            <^> j <| "id"
            <*> j <| "name"
            <*> j <|? "description"
            <*> j <| "html_url"
    }
    
    private static func urlFromString(str: String) -> NSURL? {
        return NSURL(string: str)
    }
}

extension RepoArgo: Printable {
    var description: String {
        return "RepoArgo - repoId: \(repoId)\nname: \(name)\ndescription: \(desc)\nURL: \(url)"
    }
}
