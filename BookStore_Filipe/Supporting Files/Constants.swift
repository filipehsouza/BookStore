//
//  Constants.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

struct Constants {
    
    static let URL:String = "https://www.googleapis.com/books/v1/volumes"
    
    static let reuseIdentifier = "BookCell"
    static let itemsPerRow:CGFloat = 2
    static let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    
    static let defaultsKey = "FavoriteBooks"
}
