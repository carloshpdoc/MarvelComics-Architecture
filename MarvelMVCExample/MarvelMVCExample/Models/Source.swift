//
//  Source.swift
//  MarvelMVCExample
//
//  Created by carloshenrique.carmo on 21/04/19.
//  Copyright © 2019 carloshpdoc. All rights reserved.
//

import Foundation
import UIKit

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total:Int
    let count: Int
    let results: [Comics]
}

struct Comics: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let urls: [ComicsUrls]
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey{
        case path
        case ext = "extension"
    }
}

struct ComicsUrls: Codable {
    let type: String
    let url: String
}
