//
//  BookListRouter.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

class BookListRouter: BookListRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: nil)
    }
    
    static func createModule() -> UINavigationController {
        
        guard let viewController = mainstoryboard.instantiateViewController(withIdentifier: "BookListViewController") as? BookListViewController else {
            fatalError("ViewController is not an instance of BookListViewController")
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: BookListPresenterProtocol & BookListInteractorDelegate = BookListPresenter()
        let interactor: BookListInteractorProtocol = BookListInteractor()
        let router: BookListRouterProtocol = BookListRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navigationController
    }
    
    func pushToBookDetail(on view:BookListPresenterDelegate, for book:Book) {
        let bookDetailViewController = BookDetailRouter.createModule(with: book)
        
        guard let viewController = view as? BookListViewController else {
            return
        }
        
        viewController.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
    
}
