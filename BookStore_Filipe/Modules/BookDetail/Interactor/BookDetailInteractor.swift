//
//  BookDetailInteractor.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

class BookDetailInteractor: BookDetailInteractorProtocol {
    
    weak var presenter: BookDetailInteractorDelegate?
    var book: Book?
    var storage:LocalStorageProtocol = LocalStorage.shared
    
    func getBook() -> Book {
        guard let book = book else {
            fatalError("No Book provided")
        }
        return book
    }
    
    func isFavorite() -> Bool {
        let favoriteList = storage.get()
        let bookDetail = getBook()
        let isFavorite = favoriteList.contains(bookDetail.id)
        return isFavorite
    }
    
    func favoriteBook() {
        guard let id = book?.id else {
            return
        }
        storage.save(string: id)
        presenter?.bookSaved()
    }
    
    func unfavoriteBook() {
        guard let id = book?.id else {
            return
        }
        
        storage.delete(string: id)
        presenter?.bookSaved()
    }
}
