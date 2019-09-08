//
//  HModel.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import Foundation

struct SearchResult : Codable{
    
    var results : Result
    
}

struct Result : Codable {
    
    var albummatches : AlbumMatchs?
    var artistmatches : AlbumMatchs?
    var trackmatches : AlbumMatchs?
    
}

struct AlbumMatchs : Codable {
    
    var album : [Album]?
    var artist : [Album]?
    var track : [Album]?
}

struct Album : Codable{
    
    var name : String?
    var artist : String?
    var url : String?
    var image = [ImageInfo]()
    
}


struct ImageInfo : Codable{
    
    var text : String?
    var size : String?
    
    enum CodingKeys: String, CodingKey {
        case text = "#text", size
    }
}
