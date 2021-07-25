//
//  VolumeInfo.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation
import Unrealm

struct VolumeInfo: Codable, Realmable {
    var title: String = ""
    var authors: [String] = [String]()
    var volumeInfoDescription: String?
    var imageLinks: ImageLinks = ImageLinks()

    enum CodingKeys: String, CodingKey {
        case title, authors
        case volumeInfoDescription = "description"
        case imageLinks
    }
}
