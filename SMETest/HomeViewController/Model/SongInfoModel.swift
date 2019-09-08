//
//  SongInfoModel.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import UIKit

class SongInfoModel{
    
    var type : String?
    var name : String?
    var artist : String?
    var ImageUrl : String?
    
    init(type:String,name:String,artist:String,ImageUrl:String) {
        self.type = type
        self.name = name
        self.artist = artist
        self.ImageUrl = ImageUrl
    }
    
}
