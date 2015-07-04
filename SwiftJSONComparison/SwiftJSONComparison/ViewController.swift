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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        argoRequest()
        jsonJoyRequest()
        objectMapperRequest()
        swiftyJSONRequest()
        
    }
    
    // MARK: Helpers
    
    private func argoRequest() {
        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                if let d: AnyObject = data {
                    
                    let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
                    
                    let repo: RepoArgo? = decode(json)
                    
                    println(repo!)
                }
        }
    }
    
    private func jsonJoyRequest() {
        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                if let d: AnyObject = data {
                    
                    let repo = RepoJSONJoy(JSONDecoder(d))
                    
                    println(repo)
                }
        }
    }
    
    private func objectMapperRequest() {
        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                if let d: AnyObject = data {
                
                    let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSDictionary
                
                    let repo = Mapper<RepoObjectMapper>().map(json)
                    
                    println(repo!)
                }
        }
    }
    
    private func swiftyJSONRequest() {
        Alamofire.request(.GET, "https://api.github.com/repos/hkellaway/swift-json-comparison", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
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
}

