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
    var storage:LocalStorageProtocol = RealmStorage.shared
    
    func getBook() -> Book {
        guard let book = book else {
            fatalError("No Book provided")
        }
        return book
    }
    
    func isFavorite() -> Bool {
        let favoriteList = storage.all()
        let bookDetail = getBook()
        let isFavorite = favoriteList.contains(bookDetail.id)
        return isFavorite
    }
    
    func favoriteBook() {
        guard let book = book else {
            return
        }
        storage.add(book)
        presenter?.bookSaved()
    }
    
    func unfavoriteBook() {
        guard let book = book else {
            return
        }
        
        storage.delete(book)
        presenter?.bookSaved()
    }
}
