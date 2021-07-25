//
//  LocalStorageTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 24/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble
import Unrealm
import Realm
import RealmSwift

@testable import BookStore_Filipe

class LocalStorageTests: XCTestCase {
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    override func setUp() {
        super.setUp()
        Realm.registerRealmables(Book.self)
    }
    
    override func tearDown() {
        super.tearDown()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testAll() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        try! realm.write {
            self.realm.add(book, update: .all)
        }
        
        let array = RealmStorage.shared.all()
        
        expect(array).toNot(beEmpty())
        expect(array[0]).to(equal("1"))
    }
    
    func testAdd() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        RealmStorage.shared.add(book)
        
        let books = realm.objects(Book.self)
        var array:[String] = [String]()
        for book in books {
            array.append(book.id)
        }
        
        expect(array).toNot(beEmpty())
        expect(array[0]).to(equal("1"))
    }
    
    func testDelete() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        RealmStorage.shared.delete(book)
        
        let books = realm.objects(Book.self)
        
        expect(books).to(beEmpty())
    }
    
}
