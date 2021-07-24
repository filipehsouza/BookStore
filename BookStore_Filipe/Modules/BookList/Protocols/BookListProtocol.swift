//
//  BookListProtocol.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

protocol BookListPresenterDelegate: class {
    func showBooks(filtered: Bool)
    func showError()
    func showLoading()
    func hideLoading()
}

protocol BookListPresenterProtocol: class {
    var view: BookListPresenterDelegate? { get set }
    var interactor: BookListInteractorProtocol? { get set }
    var router: BookListRouterProtocol? { get set }
    var isFiltered:Bool { get set }
    
    func updateView()
    func refreshView()
    func getBookListCount() -> Int?
    func getAllBookListCount() -> Int?
    func getBook(index: Int) -> Book?
    func showBookDetail(for index:Int)
}

protocol BookListInteractorProtocol: class {
    var presenter: BookListInteractorDelegate? { get set }
    var books: [Book]? { get set }
    
    func fetchBookList()
    func getBookList(filtered:Bool) -> [Book]?
}

protocol BookListInteractorDelegate: class {
    func bookListFetched()
    func bookListFetchedFailed()
}

protocol BookListRouterProtocol: class {
    static func createModule() -> UINavigationController
    func pushToBookDetail(on view:BookListPresenterDelegate, for book:Book)
}
