//
//  BookDetailPresenterTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookDetailPresenterTests: XCTestCase {
    
    var sut: BookDetailPresenter?
    var mockView: MockBookDetailView?
    var mockInteractor: MockBookDetailInteractor?
    var mockRouter: MockBookDetailRouter?
    
    override func setUp() {
        mockView = MockBookDetailView()
        mockInteractor = MockBookDetailInteractor()
        mockRouter = MockBookDetailRouter()
        sut = BookDetailPresenter()
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        mockInteractor?.presenter = sut
        super.setUp()
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetBookDetail() {
        sut?.getBookDetail()
        
        expect(self.mockView?.isSuccess).to(beTrue())
    }
    
    func testGetBookDetailError() {
        sut?.interactor = nil
        
        expect(self.sut?.getBookDetail()).to(throwAssertion())
    }
    
    
    func testFavoriteBook() {
        sut?.favoriteBook()
        
        expect(self.mockInteractor?.isSuccess).to(beTrue())
    }
    
    func testeUnfavoriteBook() {
        sut?.unfavoriteBook()
        
        expect(self.mockInteractor?.isSuccess).to(beTrue())
    }
    
    func testOpenBuyLink() {
        sut?.openBuyLink()
        
        expect(self.mockRouter?.isSuccess).to(beTrue())
    }
    
    func testBookSaved() {
        mockInteractor?.presenter?.bookSaved()
        
        expect(self.mockView?.isSuccess).to(beTrue())
    }
    
}

class MockBookDetailView: BookDetailPresenterDelegate {
    
    var isSuccess = false
    
    func showDetail(for book: Book, isFavorite: Bool) {
        isSuccess = true
    }
    
}

class MockBookDetailInteractor: BookDetailInteractorProtocol {
    
    var presenter: BookDetailInteractorDelegate?
    var book: Book?
    
    var isSuccess = false
    
    func getBook() -> Book {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        return book!
    }
    
    func isFavorite() -> Bool {
        isSuccess = true
        return isSuccess
    }
    
    func favoriteBook() {
        isSuccess = true
    }
    
    func unfavoriteBook() {
        isSuccess = true
    }
    
    
}

class MockBookDetailRouter: BookDetailRouterProtocol {
    
    var isSuccess: Bool = false
    
    static func createModule(with book: Book) -> UIViewController {
        return UIViewController()
    }
    
    func open(url: String) {
        isSuccess = true
    }
    
}
