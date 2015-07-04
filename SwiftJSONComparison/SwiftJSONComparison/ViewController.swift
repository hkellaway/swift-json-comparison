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
        
        let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
            
        let repo: RepoArgo? = decode(json)
            
        println(repo!)
    }
    
    private func jsonJoyResponseHandler(data: AnyObject) {
        
        let repo = RepoJSONJoy(JSONDecoder(data))
    
        println(repo)
    }
    
    private func objectMapperResponseHandler(data: AnyObject) {
        
        let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
            
        let repo = Mapper<RepoObjectMapper>().map(json)
            
        println(repo!)
    }
    
    private func swiftyJSONResponseHandler(data: AnyObject) {
        
        let json = JSON(data: data as! NSData, options: .allZeros, error: nil)
        var repo: RepoSwiftyJSON?
            
        if let repoDict = json.dictionary {
                
            let repoId = repoDict["id"]!.int!
            let name = repoDict["name"]!.string!
            let desc = repoDict["description"]!.string!
            let url = repoDict["html_url"]!.URL!
                
            repo = RepoSwiftyJSON(repoId: repoId, name: name, desc: desc, url: url)
        }
        
        println(repo!)
    }
}
