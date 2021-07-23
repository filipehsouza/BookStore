//
//  BookListPresenter.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

class BookListPresenter: BookListPresenterProtocol {
    
    weak var view: BookListPresenterDelegate?
    var interactor: BookListInteractorProtocol?
    var router: BookListRouterProtocol?
    var isFiltered: Bool = false
    
    func updateView() {
        view?.showLoading()
        interactor?.fetchBookList()
    }
    
    func refreshView() {
        isFiltered = !isFiltered
        view?.showBooks(filtered: isFiltered)
    }
    
    func getBookListCount() -> Int? {
        guard let book = interactor?.getBookList(filtered: isFiltered) else {
            return nil
        }
        return book.count
    }
    
    func getAllBookListCount() -> Int? {
        guard let book = interactor?.getBookList(filtered: false) else {
            return nil
        }
        return book.count
    }
    
    func getBook(index: Int) -> Book? {
        guard let book = interactor?.getBookList(filtered: isFiltered) else {
            return nil
        }
        return book[index]
    }
    
    func showBookDetail(for index: Int) {
        guard let book = interactor?.getBookList(filtered: isFiltered)?[index] else {
            return
        }
        router?.pushToBookDetail(on: view!, for: book)
    }
    
}

extension BookListPresenter: BookListInteractorDelegate {
    
    func bookListFetched() {
        view?.hideLoading()
        view?.showBooks(filtered: isFiltered)
    }
    
    func bookListFetchedFailed() {
        view?.hideLoading()
        view?.showError()
    }
    
    private func calculateIndexPathsToReload(from newBooks: [Book]) -> [IndexPath] {
        guard let books = interactor?.getBookList(filtered: isFiltered) else {
            fatalError()
        }
        let startIndex = books.count - newBooks.count
        let endIndex = startIndex + newBooks.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
