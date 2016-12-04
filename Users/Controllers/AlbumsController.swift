//
//  AlbumsController.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import Alamofire


/// AlbumsController manages user's albums.
class AlbumsController: NSObject {
    
    
    /// Entrypoint to manage user's albums.
    static let albums = AlbumsController()
    
    
    /// Get albums owned by a user.
    ///
    /// - Parameters:
    ///   - userId: user owning the albums.
    ///   - completion: get the albums from the API.
    func get(forUser userId: Int, completion: @escaping ([Album], NSError?) -> (Void)) {
        Alamofire.request("https://jsonplaceholder.typicode.com/users/\(userId)/albums").responseJSON { response in
            guard let JSON = response.result.value as? [[String: Any]] else {
                completion([], NSError(domain: "com.rstudio.Users", code: 500, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch users."]))
                return
            }
            
            var albums: [Album] = []
            for jsonAlbum in JSON {
                if let album = Album(json: jsonAlbum) {
                    albums.append(album)
                }
            }

            completion(albums, nil)
        }
    }
    
    
    /// Get specific pictures of an album.
    ///
    /// - Parameters:
    ///   - albumId: album of those pictures.
    ///   - completion: get the pictures from the API.
    func getDetail(forAlbum albumId: Int, completion: @escaping ([String], NSError?) -> (Void)) {
        Alamofire.request("https://jsonplaceholder.typicode.com/albums/\(albumId)/photos").responseJSON { response in
            guard let JSON = response.result.value as? [[String: Any]] else {
                completion([], NSError(domain: "com.rstudio.Users", code: 500, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch users."]))
                return
            }
            
            var thumbnails: [String] = []
            for jsonPicture in JSON {
                if let thumbnail = jsonPicture["thumbnailUrl"] as? String {
                    thumbnails.append(thumbnail.replacingOccurrences(of: "http", with: "https"))
                }
            }

            completion(thumbnails, nil)
        }
        
    }
}
