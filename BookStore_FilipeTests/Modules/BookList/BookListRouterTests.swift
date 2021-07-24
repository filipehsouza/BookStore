//
//  BookListRouterTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 23/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class BookListRouterTests: XCTestCase {
    
    func testCreateModule() {
        
        let navigationController = BookListRouter.createModule()
        let viewController = navigationController.topViewController as? BookListViewController
        
        expect(viewController).toNot(beNil())
        expect(viewController?.presenter).toNot(beNil())
    }
}
