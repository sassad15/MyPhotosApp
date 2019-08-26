//
//  Photo.swift
//  MyPhotoApp
//
//  Created by muhammad on 8/23/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation


class Photo : Decodable {
    
    let id : Int
    let title : String
    let thumbnailUrl : String
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailUrl
    }
    
}
