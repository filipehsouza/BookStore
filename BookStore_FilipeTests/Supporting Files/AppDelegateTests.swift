//
//  AppDelegateTests.swift
//  BookStore_FilipeTests
//
//  Created by FAP on 24/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import XCTest
import Nimble

@testable import BookStore_Filipe

class AppDelegateTests: XCTestCase {
    
    func testAppDelegate() {
        let bool = AppDelegate().application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        expect(bool).to(beTrue())
    }
}
