//
//  ViewController.swift
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

import Alamofire
import Argo
import JSONJoy
import ObjectMapper
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    enum Library {
        case Argo
        case JSONJoy
        case ObjectMapper
        case SwiftyJSON
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        requestWith(.Argo)
        requestWith(.JSONJoy)
        requestWith(.ObjectMapper)
        requestWith(.SwiftyJSON)
    }
    
    func requestWith(library: Library) {

        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters: nil).response { (request, response, data, error) in
            
            if let e = error {
                
                println("ERROR = \(e)")
            }
            
            if let d: AnyObject = data {
                
                let responseHandler = self.responseHandlerForLibrary(library)
                
                responseHandler(d)
            }
        }
    }
    
    // MARK: Helpers
    
    private func responseHandlerForLibrary(library: Library) -> ((AnyObject) -> ()) {
        switch library {
        case .Argo:
                return argoResponseHandler
        case .JSONJoy:
                return jsonJoyResponseHandler
        case .ObjectMapper:
            return objectMapperResponseHandler
        case .SwiftyJSON:
            return swiftyJSONResponseHandler
        }
    }
    
    private func argoResponseHandler(data: AnyObject) {
        
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions(0), error: nil)
        
        if let j: AnyObject = json {
            
            let repo: RepoArgo? = decode(j)
            
            println(repo!)
        }
    }
    
    private func jsonJoyResponseHandler(data: AnyObject) {
        
        let repo = RepoJSONJoy(JSONDecoder(data))
    
        println(repo)
    }
    
    private func objectMapperResponseHandler(data: AnyObject) {
        
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions(0), error: nil)
        
        if let j: AnyObject = json {
            
            let repo = Mapper<RepoObjectMapper>().map(j)
            
            println(repo!)
        }
    }
    
    private func swiftyJSONResponseHandler(data: AnyObject) {
        
        let json = JSON(data: data as! NSData, options: .allZeros, error: nil)
            
        if let repoDict = json.dictionary {
            
            if let ownerDict = repoDict["owner"]?.dictionary {
                
                let ownerId = ownerDict["id"]!.int!
                let username = ownerDict["login"]!.string!
                let repoId = repoDict["id"]!.int!
                let name = repoDict["name"]!.string!
                let desc = repoDict["description"]!.string!
                let url = repoDict["html_url"]!.URL!
                
                let owner = RepoOwnerSwiftyJSON(ownerId: ownerId, username: username)
                
                let repo = RepoSwiftyJSON(repoId: repoId, name: name, desc: desc, url: url, owner: owner)
                
                println(repo)
            }
        }
    }
}
