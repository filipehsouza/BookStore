//
//  BookDetailInteractorTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookDetailInteractorTests: XCTestCase {
    
    var sut: BookDetailInteractor?
    var mockPresenter: MockBookDetailPresenter?
    var mockStorage: LocalStorageProtocol?
    
    override func setUp() {
        sut = BookDetailInteractor()
        mockPresenter = MockBookDetailPresenter()
        mockStorage = MockLocalStorage()
        sut?.presenter = mockPresenter
        sut?.storage = mockStorage!
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        mockStorage = nil
        super.tearDown()
    }
    
    func testGetBookSuccess() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        sut?.book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        let book = sut?.getBook()
        expect(book?.id).to(equal("1"))
    }
    
    func testGetBookFailure() {
        expect{ self.sut?.getBook() }.to(throwAssertion())
    }
    
    func testIsFavoriteBookTrue() {
        mockStorage?.save(string: "1")
        
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        sut?.book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        expect(self.sut?.isFavorite()).to(beTrue())
    }
    
    func testIsFavoriteBookFalse() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        sut?.book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        expect(self.sut?.isFavorite()).to(beFalse())
    }
    
    func testFavoriteBook() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        sut?.book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        sut?.favoriteBook()
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testFavoriteBookNil() {
        sut?.favoriteBook()
        expect(self.mockPresenter?.isSuccess).to(beFalse())
    }
    
    func testUnfavoriteBookNil() {
        sut?.unfavoriteBook()
        expect(self.mockPresenter?.isSuccess).to(beFalse())
    }
    
    func testUnfavoriteBook() {
        mockStorage?.save(string: "1")
        
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        sut?.book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        sut?.unfavoriteBook()
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
}

class MockBookDetailPresenter: BookDetailInteractorDelegate {
    
    var isSuccess = false
    var error: Error?
    
    func bookSaved() {
        isSuccess = true
    }
    
}

class MockLocalStorage: LocalStorageProtocol {
    
    var array:[String] = [String]()
    
    func save(string: String) {
        array.append(string)
    }
    
    func get() -> [String] {
        return array
    }
    
    func delete(string: String) {
        let index = array.firstIndex(of: string)
        array.remove(at: index!)
    }
}
