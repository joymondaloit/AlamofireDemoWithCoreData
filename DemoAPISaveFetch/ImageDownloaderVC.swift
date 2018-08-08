//
//  ImageDownloaderVC.swift
//  DemoAPISaveFetch
//
//  Created by Joy Mondal on 01/08/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit

class ImageDownloaderVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var informationArray = [Log]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return informationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : ImageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as? ImageTableViewCell
        if cell == nil
        {
            tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
            cell =  tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as? ImageTableViewCell
        }
        
        if let url = URL(string: informationArray[indexPath.row].thumbnailUrl!)
        {
            cell?.profileImage.contentMode = .scaleAspectFit
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    cell?.profileImage.image = UIImage(data: data)
                }
            }
        }
    
        
        return cell!
    }
    
    
  
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
 
}
