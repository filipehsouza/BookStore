//
//  LocalStorage.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation
import Unrealm

protocol LocalStorageProtocol {
    func all() -> [String]
    func add(_ book: Book)
    func delete(_ book: Book)
}

class RealmStorage: LocalStorageProtocol {
    
    static var shared:RealmStorage = {
        let instance = RealmStorage()
        return instance
    }()
    
    func all() -> [String] {
        guard let realm = try? Realm() else { return [String]() }
        let items = realm.objects(Book.self)
        var array:[String] = [String]()
        for item in items {
            array.append(item.id)
        }
        return array
    }
    
    func add(_ book: Book) {
        guard let realm = try? Realm() else { return }
        try! realm.write {
            realm.add(book, update: .all)
        }
    }
    
    func delete(_ book: Book) {
        guard let realm = try? Realm() else { return }
        try! realm.write {
            realm.delete(book)
        }
    }
    
}
