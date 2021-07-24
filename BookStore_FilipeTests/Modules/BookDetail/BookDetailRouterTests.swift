//
//  BookDetailRouterTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookDetailRouterTests: XCTestCase {
    
    
    func testCreateModule() {
        let imageLinks = ImageLinks(smallThumbnail: "", thumbnail: "")
        let volumeInfo = VolumeInfo(title: "", authors: [""], volumeInfoDescription: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "")
        let book = Book(kind: "", id: "1", selfLink: "", volumeInfo: volumeInfo, saleInfo: saleInfo)
        
        let viewController = BookDetailRouter.createModule(with: book) as? BookDetailViewController
        
        expect(viewController).toNot(beNil())
        expect(viewController?.presenter).toNot(beNil())
    }
}
