//
//  BookListInteractorTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble
import OHHTTPStubs

@testable import BookStore_Filipe

class BookListInteractorTests: XCTestCase {
    
    var sut: BookListInteractor?
    var mockPresenter: BookListInteractorDelegateMock?
    
    override func setUp() {
        sut = BookListInteractor()
        mockPresenter = BookListInteractorDelegateMock()
        sut?.presenter = mockPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testFetchBookListSuccess() {
        stub(condition: isMethodGET()) { (request) in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("book_volumes.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        sut?.fetchBookList()
        expect(self.mockPresenter?.isSuccess).toEventually((beTrue()))
        
    }
    
    func testFetchBookListFailue() {
        stub(condition: isMethodGET()) { (request) in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("book_no_volumes.json", type(of: self))!,
                statusCode: 422,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        sut?.fetchBookList()
        expect(self.mockPresenter?.isSuccess).toEventually((beTrue()))
        
    }
    
    func testFetchBookListSecondRequest() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        let books = [book]
        sut?.books = books
        
        stub(condition: isMethodGET()) { (request) in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("book_volumes.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        sut?.fetchBookList()
        expect(self.mockPresenter?.isSuccess).toEventually((beTrue()))
    }
    
    
    func testFetchBookListIsFetchingTrue() {
        sut?.isFetchInProgress = true
        sut?.fetchBookList()
        
        expect(self.mockPresenter?.isSuccess).to(beFalse())
    }
    
    func testGetBookList() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        let books = [book]
        sut?.books = books
        
        let bookList = sut?.getBookList(filtered: false)
        
        expect(bookList).to(haveCount(1))
    }
    
    func testGetBookListFiltered() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        let books = [book]
        sut?.books = books
        
        let bookList = sut?.getBookList(filtered: true)
        
        expect(bookList).to(beEmpty())
    }
    
}


class BookListInteractorDelegateMock: BookListInteractorDelegate {
    
    var isSuccess = false
    
    func bookListFetched() {
        isSuccess = true
    }
    
    func bookListFetchedFailed() {
        isSuccess = true
    }
    
}

