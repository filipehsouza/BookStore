//
//  BookListViewController.swift
//  BookStore_Filipe
//
//  Created by FAP on 21/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit
import Kingfisher
import ProgressHUD

class BookListViewController: UIViewController {
    
    var presenter: BookListPresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var favoriteListButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
    }
    
    @IBAction func filterFavoriteList() {
        presenter?.refreshView()
    }
    
}

extension BookListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getBookListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? BookListCell else {
            fatalError("View is not an instance of BookListCell")
        }
        guard let thumbnail = presenter?.getBook(index: indexPath.row)?.volumeInfo.imageLinks.thumbnail else {
            fatalError("No thumbnail provided")
        }
        let url = URL(string: thumbnail)!
        cell.imageView?.kf.setImage(with: url)
        
        return cell
    }
    
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }
}

extension BookListViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let count = presenter?.getAllBookListCount() else {
            return
        }
        guard let indexPath =  indexPaths.last else {
            return
        }
        if indexPath.row == count - 1 {
            presenter?.updateView()
        }
    }
    
}

extension BookListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showBookDetail(for: indexPath.row)
    }
    
}

extension BookListViewController: BookListPresenterDelegate {
    
    func showLoading() {
        ProgressHUD.show("Loading")
    }
    
    func hideLoading() {
        ProgressHUD.dismiss()
    }
    
    func showBooks(filtered: Bool) {
        DispatchQueue.main.async {
            if filtered {
                self.favoriteListButton?.title = "All"
            } else {
                self.favoriteListButton?.title = "Favorites"
            }
        }
        collectionView?.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Books", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
