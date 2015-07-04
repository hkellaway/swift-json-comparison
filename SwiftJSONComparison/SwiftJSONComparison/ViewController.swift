//
//  ViewController.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Alamofire
import Argo
import ObjectMapper
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        argoRequest()
        objectMapperRequest()
        swiftyJSONRequest()
        
    }
    
    // MARK: Helpers
    
    private func argoRequest() {
        Alamofire.request(.GET, "http://www.refugerestrooms.org/api/v1/restrooms.json", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                if let d: AnyObject = data {
                    
                    let json: NSArray = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSArray
                    
                    let restroom: ModelArgo? = decode(json[0])
                    
                    println(restroom!)
                }
        }
    }
    
    private func objectMapperRequest() {
        Alamofire.request(.GET, "http://www.refugerestrooms.org/api/v1/restrooms.json", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                if let d: AnyObject = data {
                
                    let json: NSArray = NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions(0), error: nil) as! NSArray
                
                    let restroom = Mapper<ModelObjectMapper>().map(json[0])
                    
                    println(restroom!)
                }
        }
    }
    
    private func swiftyJSONRequest() {
        Alamofire.request(.GET, "http://www.refugerestrooms.org/api/v1/restrooms.json", parameters:nil)
            .response { (request, response, data, error) in
                if let e = error {
                    println("ERROR = \(e)")
                }
                
                let json = JSON(data: data as! NSData, options: .allZeros, error: nil)

                if let restroomsArray = json.array {
                     var restrooms = [ModelSwiftyJSON]()
                    
                    for restroomDict in restroomsArray {
                        var restroomId: Int? = restroomDict["id"].int
                        var name: String? = restroomDict["name"].string
                        
                        var restroom: ModelSwiftyJSON? = ModelSwiftyJSON(restroomId: restroomId!, name: name!)
                        restrooms.append(restroom!)
                    }
                    
                    println(restrooms[0])
                }
        }
    }
}

