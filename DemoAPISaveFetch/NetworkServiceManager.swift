//
//  NetworkServiceManager.swift
//  DemoAPISaveFetch
//
//  Created by Joy Mondal on 31/07/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit
import Alamofire


class NetworkServiceManager: NSObject
{
//    var urlString = "https://jsonplaceholder.typicode.com/albums/1/photos"
    var urlString = "https://sfv2-wfe-dev.inadev.net/api/configure_application_workflowengine"
    var items = NSDictionary()
//    func createAPIRequest(completion c : @escaping (NSDictionary)->() )
//    {
//        let url = URL(string: urlString)
//        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            //print(response)
//           // print(response.result.value!)
//            self.items = response.result.value as! NSDictionary
//            c(self.items)
//        }
    
            
    func createAPICall(completion : @escaping (Any)->())
        {
            let parameters = [
                "application": "7172",
                "current_version": "9.7",
                "device_type": "ipad",
                "language": "en",
                "current_language": "en"
                ]
            let headers = ["content-type" : "application/json"]
            let url = URL(string: urlString)
            
            Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                self.items = response.result.value as! NSDictionary
                completion(self.items)
            }
            
            
        }
        
    }


