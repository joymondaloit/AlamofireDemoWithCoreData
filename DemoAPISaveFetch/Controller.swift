//
//  Controller.swift
//  DemoAPISaveFetch
//
//  Created by Joy Mondal on 01/08/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit

typealias Response = (Any) -> ()

class Controller: NSObject {

    static let shared = Controller()
    let dataBaseManager = DataBaseManager.shared()
    
    
    func saveAddLogInfoRequest(albumId:Int64,id:Int64,title:String,url:String,thumbnailUrl: String, completion c: Response)
    {
        
        let details = Log(context: dataBaseManager.managedContext)
    
        details.albumId = albumId
        details.id = id
        details.title = title
        details.url = url
        details.thumbnailUrl = thumbnailUrl
        
        dataBaseManager.save { (result) in
            switch result
            { 
            case .success(let str):
                c(str)
                //print(str)
                
            case .failure(let str):
                c(str)
            }
        }
        
        
        
    }
    
    func handleGetUser(completion c: Response)
    {
        //dataBaseManager.delegate = self
        dataBaseManager.fetch { (result) in
            switch result
            {
            case .success(let str):
                c(str)
                
            case .failure(let str):
                c(str)
            }
        }
    }
    
}
