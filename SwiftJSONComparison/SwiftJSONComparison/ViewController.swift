//
//  ViewController.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Alamofire
import Argo
import JSONJoy
import ObjectMapper
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    enum Library:String {
        case Argo = "Argo"
        case JSONJoy = "JSON Joy"
        case ObjectMapper = "Object Mapper"
        case SwiftyJSON = "Swift JSON"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestFor(.Argo)
        requestFor(.JSONJoy)
        requestFor(.ObjectMapper)
        requestFor(.SwiftyJSON)
    }
    
    func requestFor(library: Library) {
        
        let completion = completionForLibrary(library)
        
        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters: nil).response(completion)
    }
    
    // MARK: Helpers
    
    private func completionForLibrary(library: Library) -> ((NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> ()) {
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
    
    private func argoResponseHandler(request: NSURLRequest, response: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) {
        if let d: AnyObject = data {
            
            let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
            
            let repo: RepoArgo? = decode(json)
            
            println(repo!)
        }
    }
    
    private func jsonJoyResponseHandler(request: NSURLRequest, response: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) {
        if let d: AnyObject = data {
    
            let repo = RepoJSONJoy(JSONDecoder(d))
    
            println(repo)
        }
    }
    
    private func objectMapperResponseHandler(request: NSURLRequest, response: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) {
        if let d: AnyObject = data {
            
            let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
            
            let repo = Mapper<RepoObjectMapper>().map(json)
            
            println(repo!)
        }
    }
    
    private func swiftyJSONResponseHandler(request: NSURLRequest, response: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) {
        if let d: AnyObject = data {
            
            let json = JSON(data: d as! NSData, options: .allZeros, error: nil)
            
            if let repoDict = json.dictionary {
                
                let repoId = repoDict["id"]!.int!
                let name = repoDict["name"]!.string!
                let desc = repoDict["description"]!.string!
                let url = repoDict["html_url"]!.URL!
                
                let repo = RepoSwiftyJSON(repoId: repoId, name: name, desc: desc, url: url)
                
                println(repo)
            }
        }
    }
}

