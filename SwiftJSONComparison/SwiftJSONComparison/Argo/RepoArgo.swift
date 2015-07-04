//
//  RepoArgo.swift
//  SwiftJSONComparison
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Argo
import Runes

struct RepoArgo {
    let repoId: Int
    let name: String
    let desc: String?
    let url: NSURL
    let owner: OwnerArgo
}

extension RepoArgo: Decodable {
    static func create(repoId: Int)(name: String)(desc: String?)(urlString: String)(owner: OwnerArgo) -> RepoArgo {
        
        return RepoArgo(repoId: repoId, name: name, desc: desc, url: urlFromString(urlString)!, owner: owner)
    }
    
    static func decode(j: JSON) -> Decoded<RepoArgo> {
        return RepoArgo.create
            <^> j <| "id"
            <*> j <| "name"
            <*> j <|? "description"
            <*> j <| "html_url"
            <*> j <| "owner"
    }
    
    private static func urlFromString(str: String) -> NSURL? {
        return NSURL(string: str)
    }
}

extension RepoArgo: Printable {
    var description: String {
        return "RepoArgo - repoId: \(repoId)\nname: \(name)\ndescription: \(desc)\nURL: \(url)\nowner: \(owner)"
    }
}
