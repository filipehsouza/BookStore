//
//  BookList.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

struct BookList: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]?
}
