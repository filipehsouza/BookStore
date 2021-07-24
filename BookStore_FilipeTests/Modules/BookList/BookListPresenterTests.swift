//
//  BookListPresenterTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookListPresenterTests:XCTestCase {
    
    var sut: BookListPresenter?
    var mockView: MockBookListView?
    var mockInteractor: MockBookListInteractor?
    var mockRouter: MockBookListRouter?
    var isFiltered: Bool = false
    
    override func setUp() {
        sut = BookListPresenter()
        mockView = MockBookListView()
        mockInteractor = MockBookListInteractor()
        mockRouter = MockBookListRouter()
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        sut?.interactor?.presenter = sut
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testUpdateView() {
        sut?.updateView()
        
        expect(self.mockView?.isSuccess).to(beTrue())
        expect(self.mockInteractor?.isSuccess).to(beTrue())
    }
    
    func testRefreshView() {
        sut?.refreshView()
        
        expect(self.sut?.isFiltered).to(beTrue())
        expect(self.mockView?.isSuccess).to(beTrue())
    }
    
    func testGetBookListCount() {
        let count = sut?.getBookListCount()
        
        expect(count).to(equal(1))
    }
    
    func testGetAllBookListCount() {
        let count = sut?.getAllBookListCount()
        
        expect(count).to(equal(1))
    }
    
    func testGetBook() {
        let book = sut?.getBook(index: 0)
        
        expect(book?.id).to(equal("1"))
    }
    
    func testShowBookDetail() {
        sut?.showBookDetail(for: 0)
        
        expect(self.mockRouter?.isSuccess).to(beTrue())
    }
    
    func testShowBookDetailFatalError() {
        expect(self.sut?.showBookDetail(for: 1)).to(throwAssertion())
        sut?.interactor = nil
        expect(self.sut?.showBookDetail(for: 0)).to(throwAssertion())
    }
    
    func testBookListFetched() {
        sut?.isFiltered = true
        mockInteractor?.presenter?.bookListFetched()
        
        expect(self.mockView?.isSuccess).to(beTrue())
    }
    
    func testBookListFetchedFailed() {
        mockInteractor?.presenter?.bookListFetchedFailed()
        
        expect(self.mockView?.isSuccess).to(beTrue())
    }
    
}

class MockBookListView: BookListPresenterDelegate {
    
    var isSuccess:Bool = false
    
    func showBooks(filtered: Bool) {
        isSuccess = filtered
    }
    
    func showError() {
        isSuccess = true
    }
    
    func showLoading() {
        isSuccess = true
    }
    
    func hideLoading() {
        isSuccess = true
    }
    
}

class MockBookListInteractor: BookListInteractorProtocol {
    
    var presenter: BookListInteractorDelegate?
    var books: [Book]?
    
    var isSuccess:Bool = false
    
    func fetchBookList() {
        isSuccess = true
    }
    
    func getBookList(filtered: Bool) -> [Book]? {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        let books = [book]
        return books
    }
    
}

class MockBookListRouter: BookListRouterProtocol {
    
    var isSuccess:Bool = false
    
    static func createModule() -> UINavigationController {
        return UINavigationController()
    }
    
    func pushToBookDetail(on view: BookListPresenterDelegate, for book: Book) {
        isSuccess = true
    }
    
}
