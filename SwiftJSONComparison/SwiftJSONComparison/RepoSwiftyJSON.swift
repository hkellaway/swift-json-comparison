//
//  RepoSwiftyJSON.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Foundation

struct RepoSwiftyJSON {
    let repoId: Int
    let name: String
    let desc: String?
    let url: NSURL
}

extension RepoSwiftyJSON: Printable {
    var description: String {
        return "RepoSwiftyJSON - repoId: \(repoId)\nname: \(name)\ndescription: \(desc)\nURL: \(url)"
    }
}
