//
//  BookListInteractor.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

class BookListInteractor: BookListInteractorProtocol {
    
    weak var presenter: BookListInteractorDelegate?
    var books: [Book]?
    
    var index:Int = 0
    var isFetchInProgress:Bool = false
    
    func fetchBookList() {
        
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true
        
        let param = ["q":"ios", "maxResults":"20", "startIndex":"\(index)"]
        HTTPClient<BookList>().request(with: param) { response in
            switch response {
            case .success(let booksResponse):
                self.isFetchInProgress = false
                self.index += 20
                
                guard let itens = booksResponse.items else { return }
                if let _ = self.books {
                    self.books!.append(contentsOf: itens)
                } else {
                    self.books = itens
                }
                
                self.presenter?.bookListFetched()
            case .failure:
                self.isFetchInProgress = false
                self.presenter?.bookListFetchedFailed()
            }
        }
    }
    
    func getBookList(filtered:Bool) -> [Book]? {
        if filtered {
            return getFilteredBookList()
        }
        return getAllBooksList()
    }
    
    private func getAllBooksList() -> [Book]? {
        guard let bookList = books else {
            return nil
        }
        return bookList
    }
    
    private func getFilteredBookList() -> [Book]? {
        guard let bookList = books else {
            return nil
        }
        
        let favoriteBooks = LocalStorage.shared.get()
        let filteredList = bookList.filter({ favoriteBooks.contains($0.id) })
        
        return filteredList
    }
    
}
