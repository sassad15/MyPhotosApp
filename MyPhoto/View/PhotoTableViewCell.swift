//
//  PhotoTableViewCell.swift
//  MyPhotoApp
//
//  Created by muhammad on 8/23/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoIDLabel: UILabel!
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
   
    
    static let identifier = "photoCell"
    
   

}
