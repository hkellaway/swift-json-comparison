//
//  ViewController.swift
//  SwiftJSONComparison
//
//  Created by Harlan Kellaway on 7/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

import Alamofire
import Argo
import SwiftyJSON
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        argoRequest()
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
                    
                    println("Id: \(restroom!.restroomId)\nName: \(restroom!.name)")
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
                
                let restroom = json[0]
                
                if let restroomId = restroom["id"].int {
                    println("Id: \(restroomId)")
                }
                
                if let name = restroom["name"].string {
                    println("Name: \(name)")
                }
        }
    }
}

