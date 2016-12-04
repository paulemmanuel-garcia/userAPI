//
//  User.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

/// Represent a User.
class User: NSObject {
    
    /// Id of the User.
    var id: Int
    
    
    /// Name of the User.
    var name: String
    
    /// Username of the User.
    var username: String
    
    /// Email of the User.
    var email: String
    
    /// Custom init to instanciate an User from json.
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int, let name = json["name"] as? String,
            let username = json["username"] as? String, let email = json["email"] as? String else {
                return nil
        }

        self.id = id
        self.name = name
        self.username = username
        self.email = email
    }
}
