//
//  Item.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation
import Unrealm

struct Book: Codable, Realmable {
    var kind: String = ""
    var id: String = ""
    var selfLink: String = ""
    var volumeInfo: VolumeInfo = VolumeInfo()
    var saleInfo: SaleInfo = SaleInfo()
    
    static func primaryKey() -> String? {
        return "id"
    }
}
