//
//  BookDetailProtocols.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

protocol BookDetailPresenterDelegate: class {
    func showDetail(for book:Book, isFavorite:Bool)
}

protocol BookDetailPresenterProtocol: class {
    var view: BookDetailPresenterDelegate? { get set }
    var interactor: BookDetailInteractorProtocol? { get set }
    var router: BookDetailRouterProtocol? { get set }
    
    func getBookDetail()
    func favoriteBook()
    func unfavoriteBook()
    func openBuyLink()
}

protocol BookDetailInteractorProtocol: class {
    var presenter: BookDetailInteractorDelegate? { get set }
    var book: Book? { get set }
    
    func getBook() -> Book
    func isFavorite() -> Bool
    func favoriteBook()
    func unfavoriteBook()
}

protocol BookDetailInteractorDelegate: class {
    func bookSaved()
}

protocol BookDetailRouterProtocol: class {
    static func createModule(with book: Book) -> UIViewController
    func open(url:String)
}
