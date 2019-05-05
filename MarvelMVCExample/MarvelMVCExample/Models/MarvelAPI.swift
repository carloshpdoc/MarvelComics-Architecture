//
//  MarvelAPI.swift
//  MarvelMVCExample
//
//  Created by carloshenrique.carmo on 21/04/19.
//  Copyright © 2019 carloshpdoc. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    static private let basePath = "https://gateway.marvel.com/v1/public/comics?"
    static private let privateKey = "your Private Key"
    static private let publicKey = "your Public Key"
    static private let limit = 50
    
    class func loadComics(page: Int = 0, onComplete: @escaping(MarvelInfo?) -> Void ) {
        let offset = page * limit
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&title=avengers&" + getCredentials()
print("url=\(url)")
        Alamofire.request(url).responseJSON { (response) in

            guard let data = response.data, let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                marvelInfo.code == 200 else {
                    onComplete(nil)
                    return
            }
            onComplete(marvelInfo)
        }
    }
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
