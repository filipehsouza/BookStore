//
//  BookDetailViewController.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitle: UILabel?
    @IBOutlet weak var bookAuthor: UILabel?
    @IBOutlet weak var bookDescription: UITextView?
    @IBOutlet weak var bookBuyButton: UIButton?
    
    var presenter:BookDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getBookDetail()
    }
    
    @objc
    func favoriteBook() {
        presenter?.favoriteBook()
    }
    
    @objc
    func unfavoriteBook() {
        presenter?.unfavoriteBook()
    }
    
    @IBAction func openLink() {
        presenter?.openBuyLink()
    }

}

extension BookDetailViewController: BookDetailPresenterDelegate {
    
    func showDetail(for book:Book, isFavorite:Bool) {
        bookTitle?.text = book.volumeInfo.title
        bookAuthor?.text = book.volumeInfo.authors.joined(separator: ", ")
        bookDescription?.text = book.volumeInfo.volumeInfoDescription
        
        if (book.saleInfo.buyLink == nil) {
            bookBuyButton?.isHidden = true
        }
        
        self.navigationItem.rightBarButtonItems = []
        if isFavorite {
            let unfavoriteButton = UIBarButtonItem(title: "Unfavorite", style: .plain, target: self, action: #selector(self.unfavoriteBook))
            self.navigationItem.setRightBarButton(unfavoriteButton, animated: true)
        } else {
            let favoriteButton = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(self.favoriteBook))
            self.navigationItem.setRightBarButton(favoriteButton, animated: true)
        }
    }
    
}
