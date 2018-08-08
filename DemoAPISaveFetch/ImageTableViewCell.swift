//
//  ImageTableViewCell.swift
//  DemoAPISaveFetch
//
//  Created by Joy Mondal on 01/08/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
