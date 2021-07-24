//
//  BookDetailViewTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookDetailViewTests: XCTestCase {
    
    var sut: BookDetailViewController?
    var mockPresenter: MockBookDetailPresenter2?
    
    override func setUp() {
        mockPresenter = MockBookDetailPresenter2()
        sut = makeSUT()
        mockPresenter?.view = sut
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func makeSUT() -> BookDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        sut.presenter = mockPresenter
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoad() {
        sut?.viewDidLoad()
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testFavoriteBook() {
        sut?.favoriteBook()
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testUnfavoriteBook() {
        sut?.unfavoriteBook()
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testOpenLink() {
        sut?.openLink()
        
       expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testShowDetail() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "Title", authors: ["Author"], volumeInfoDescription: "Description", imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "Link")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        sut?.showDetail(for: book, isFavorite: false)
        
        expect(self.sut?.bookTitle?.text).to(equal("Title"))
        expect(self.sut?.bookAuthor?.text).to(equal("Author"))
        expect(self.sut?.bookDescription?.text).to(equal("Description"))
        expect(self.sut?.bookBuyButton?.isHidden).to(beFalse())
    }
    
    func testShowDetailWithouBuyLink() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "Title", authors: ["Author"], volumeInfoDescription: "Description", imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: nil)
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        sut?.showDetail(for: book, isFavorite: false)
        
        expect(self.sut?.bookBuyButton?.isHidden).to(beTrue())
    }
    
    func testShowDetailFavoriteBook() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "Title", authors: ["Author"], volumeInfoDescription: "Description", imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "Link")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        sut?.showDetail(for: book, isFavorite: true)
        
        expect(self.sut?.navigationItem.rightBarButtonItem?.title).to(equal("Unfavorite"))
        
    }
}

class MockBookDetailPresenter2: BookDetailPresenterProtocol {
    
    var view: BookDetailPresenterDelegate?
    var interactor: BookDetailInteractorProtocol?
    var router: BookDetailRouterProtocol?
    
    var isSuccess = false
    
    func getBookDetail() {
        isSuccess = true
    }
    
    func favoriteBook() {
        isSuccess = true
    }
    
    func unfavoriteBook() {
        isSuccess = true
    }
    
    func openBuyLink() {
        isSuccess = true
    }
    
}
