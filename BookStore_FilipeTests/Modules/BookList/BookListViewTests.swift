//
//  BookListViewTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookListViewTests: XCTestCase {
    
    var sut: BookListViewController?
    var mockPresenter: MockBookListPresenter?
    
    override func setUp() {
        mockPresenter = MockBookListPresenter()
        sut = makeSUT()
        mockPresenter?.view = sut
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func makeSUT() -> BookListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "BookListViewController") as! BookListViewController
        sut.presenter = mockPresenter
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoad() {
        sut?.viewDidLoad()
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testFilterFavoriteList() {
        sut?.filterFavoriteList()
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testShowBooks() {
        mockPresenter?.view?.showBooks(filtered: false)
        
        expect(self.sut?.navigationItem.title).to(equal("BookList"))
        expect(self.sut?.navigationItem.rightBarButtonItem?.title).to(equal("Favorites"))
    }
    
    func testShowBooksFiltered() {
        mockPresenter?.view?.showBooks(filtered: true)
        
        expect(self.sut?.navigationItem.title).to(equal("BookList"))
        expect(self.sut?.navigationItem.rightBarButtonItem?.title).to(equal("All"))
    }
    
    func testNumberOfCell() {
        let count = sut?.collectionView?.dataSource?.collectionView(sut!.collectionView!, numberOfItemsInSection: 0)
        expect(count).to(equal(1))
    }
    
    func testCellForRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut?.collectionView?.dataSource?.collectionView(sut!.collectionView!, cellForItemAt: indexPath) as! BookListCell
        
        expect(cell.imageView).toNot(beNil())
    }
    
    func testCellForRowFatalError() {
        sut?.presenter = nil
        let indexPath = IndexPath(row: 0, section: 0)
        
        expect(self.sut?.collectionView?.dataSource?.collectionView(self.sut!.collectionView!, cellForItemAt: indexPath)).to(throwAssertion())
    }
    
    func testPrefechtRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.collectionView?.prefetchDataSource?.collectionView(sut!.collectionView!, prefetchItemsAt: [indexPath])
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
    func testPrefechtRowPresenterNil() {
        sut?.presenter = nil
        mockPresenter?.isSuccess = false
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.collectionView?.prefetchDataSource?.collectionView(sut!.collectionView!, prefetchItemsAt: [indexPath])
        
        expect(self.mockPresenter?.isSuccess).to(beFalse())
    }
    
    func testPrefechtRowIndexPathNil() {
        mockPresenter?.isSuccess = false
        sut?.collectionView?.prefetchDataSource?.collectionView(sut!.collectionView!, prefetchItemsAt: [IndexPath]())
        
        expect(self.mockPresenter?.isSuccess).to(beFalse())
    }
    
    func testDidSelectCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut?.collectionView?.delegate?.collectionView?(sut!.collectionView!, didSelectItemAt: indexPath)
        
        expect(self.mockPresenter?.isSuccess).to(beTrue())
    }
    
}

class MockBookListPresenter: BookListPresenterProtocol {
    
    var view: BookListPresenterDelegate?
    var interactor: BookListInteractorProtocol?
    var router: BookListRouterProtocol?
    
    var isFiltered: Bool = false
    
    var isSuccess: Bool = false
    
    func updateView() {
        isSuccess = true
    }
    
    func refreshView() {
        isSuccess = true
    }
    
    func getBookListCount() -> Int? {
        return 1
    }
    
    func getAllBookListCount() -> Int? {
        return 1
    }
    
    func getBook(index: Int) -> Book? {
        let imageLinks = ImageLinks(smallThumbnail: "mock", thumbnail: "mock")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        return book
    }
    
    func showBookDetail(for index: Int) {
        isSuccess = true
    }
    
}
