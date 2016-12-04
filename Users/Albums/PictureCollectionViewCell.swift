//
//  PictureCollectionViewCell.swift
//  Users
//
//  Created by Paul-Emmanuel on 04/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var pictureView: UIImageView!
    private var _pictureUrl: String!
    var pictureURL: String {
        set {
            _pictureUrl = newValue
            
            Alamofire.request(_pictureUrl).responseImage {
                response in
                
                if let image = response.result.value {
                    self.pictureView.image = image
                }
            }
        }
        get {
            return _pictureUrl
        }
    }
    
    override func prepareForReuse() {
        pictureView.image = nil
    }
}
