//
//  ImageViewController.swift
//  MyPhotoApp
//
//  Created by muhammad on 8/23/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var thumbnailUrl : String!
    
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondImageView.downloaded(from: thumbnailUrl)
    }
    
}
