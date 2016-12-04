//
//  Albums.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit


/// Represent an Album.
class Album: NSObject {
    
    /// Id if the user owning the album.
    var userId: Int
    
    /// Id of the album.
    var id: Int
    
    /// Title of the album
    var title: String
    
    /// Cutom init to instanciate an album from json.
    init?(json: [String: Any]) {
        guard let userId = json["userId"] as? Int, let id = json["id"] as? Int, let title = json["title"] as? String else {
            return nil
        }

        self.userId = userId
        self.id = id
        self.title = title
    }
}
