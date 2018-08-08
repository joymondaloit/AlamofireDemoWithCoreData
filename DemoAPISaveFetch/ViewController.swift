//
//  ViewController.swift
//  DemoAPISaveFetch
//
//  Created by Joy Mondal on 01/08/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let objController = Controller()
    let objNetworkServiceManager = NetworkServiceManager()
    @IBOutlet weak var infoTableView: UITableView!
    var allInfoFromJson = NSDictionary()
    var data = NSArray()
     var allDetails = [Log]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.isHidden = false
        self.activityIndicator.startAnimating()
        objNetworkServiceManager.createAPICall { (jsonResponse) in
            self.containerView.isHidden = true
            self.activityIndicator.stopAnimating()
            self.allInfoFromJson = jsonResponse as! NSDictionary
            print(self.allInfoFromJson)
            
        }
//        objNetworkServiceManager.createAPIRequest { (result) in
//            self.containerView.isHidden = true
//            self.activityIndicator.stopAnimating()
//            self.allInfoFromJson = result
//            self.data = self.allInfoFromJson.value(forKey: "data") as! NSArray
//
//
//
//            self.saveAllData()
//            self.objController.handleGetUser { (result) in
//            self.allDetails = result as! [Log]
//            self.infoTableView.reloadData()
//        }
//       }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : TableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        if cell == nil
        {
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            cell =  tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        }
        cell?.tittleLabel.text = allDetails[indexPath.row].title
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func saveAllData()
    {
        DataBaseManager.shared().deleteAllRecords()
        
        for i in 0..<data.count
        {
             let dic = data[i] as! NSDictionary
            objController.saveAddLogInfoRequest(albumId: dic.value(forKey: "id") as! Int64, id: dic.value(forKey: "id") as! Int64, title: dic.value(forKey: "first_name") as! String, url: dic.value(forKey: "last_name") as! String, thumbnailUrl: dic.value(forKey: "avatar") as! String) { (response) in
                print(response)
            }
        }
        
        
        
//        for i in 0..<allInfoFromJson.count
//        {
//            let dic = allInfoFromJson[i] as? NSDictionary
//
//            objController.saveAddLogInfoRequest(albumId: dic?.value(forKey: "albumId") as! Int64, id:  dic?.value(forKey: "id") as! Int64, title:  dic?.value(forKey: "title") as! String, url:  dic?.value(forKey: "url") as! String, thumbnailUrl:  dic?.value(forKey: "thumbnailUrl") as! String) { (response) in
//                print(response)
//            }
//
//        }
    }
    
    @IBAction func downloadButtonAction(_ sender: UIButton)
    {
        let objImageDownloaderVC = ImageDownloaderVC(nibName: "ImageDownloaderVC", bundle: nil)
        objImageDownloaderVC.informationArray = allDetails
        self.navigationController?.pushViewController(objImageDownloaderVC, animated: true)
    }
    
    
}
