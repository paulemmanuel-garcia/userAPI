//
//  UsersController.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import Alamofire


/// UsersController manages users
class UsersController: NSObject {
    
    
    /// Entrypoint to manage users.
    static let users = UsersController()
    
    
    /// Get all users from the API
    ///
    /// - Parameter completion: get the users from the API.
    func get(completion: @escaping ([User], NSError?) -> (Void)) {
        Alamofire.request("https://jsonplaceholder.typicode.com/users").responseJSON { response in
            guard let JSON = response.result.value as? [[String: Any]] else {
                completion([], NSError(domain: "com.rstudio.Users", code: 500, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch users."]))
                return
            }

            var users: [User] = []
            for jsonUser in JSON {
                if let user = User(json: jsonUser) {
                    users.append(user)
                }
            }

            completion(users, nil)
        }
    }
}
