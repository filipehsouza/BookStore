//
//  BookDetailRouter.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

class BookDetailRouter: BookDetailRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: nil)
    }
    
    static func createModule(with book: Book) -> UIViewController {
        
        guard let viewController = mainstoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else {
            fatalError("ViewController is not an instance of BookDetailViewController")
        }
        
        let presenter: BookDetailPresenterProtocol & BookDetailInteractorDelegate = BookDetailPresenter()
        let interactor: BookDetailInteractorProtocol = BookDetailInteractor()
        let router: BookDetailRouterProtocol = BookDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.book = book
        
        return viewController
    }
    
    func open(url:String) {
        let page = URL(string: url)!
        UIApplication.shared.open(page)
    }
}
