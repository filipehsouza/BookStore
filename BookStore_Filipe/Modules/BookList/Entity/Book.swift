//
//  Item.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

struct Book: Codable {
    let kind, id: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}
