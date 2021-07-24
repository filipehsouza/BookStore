//
//  BookDetailPresenter.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

class BookDetailPresenter: BookDetailPresenterProtocol {
    
    weak var view: BookDetailPresenterDelegate?
    var interactor: BookDetailInteractorProtocol?
    var router: BookDetailRouterProtocol?
    
    func getBookDetail() {
        guard let book = interactor?.getBook() else {
            fatalError("No Book provided")
        }
        let favorite = interactor?.isFavorite()
        view?.showDetail(for: book, isFavorite: favorite ?? false)
    }
    
    func favoriteBook() {
        interactor?.favoriteBook()
    }
    
    func unfavoriteBook() {
        interactor?.unfavoriteBook()
    }
    
    func openBuyLink() {
        if let book = interactor?.getBook(),
            let buyLink = book.saleInfo.buyLink {
            router?.open(url: buyLink)
        }
    }
}

extension BookDetailPresenter: BookDetailInteractorDelegate {
    
    func bookSaved() {
        if let book = interactor?.getBook(),
            let favorite = interactor?.isFavorite() {
            view?.showDetail(for: book, isFavorite: favorite)
        }
    }
    
}
