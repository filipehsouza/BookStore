//
//  VolumeInfo.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let volumeInfoDescription: String?
    let imageLinks: ImageLinks

    enum CodingKeys: String, CodingKey {
        case title, authors
        case volumeInfoDescription = "description"
        case imageLinks
    }
}
