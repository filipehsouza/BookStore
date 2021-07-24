//
//  LocalStorage.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation

protocol LocalStorageProtocol {
    func save(string: String)
    func get() -> [String]
    func delete(string: String)
}

class LocalStorage: LocalStorageProtocol {
    
    static var shared:LocalStorage = {
        let instance = LocalStorage()
        return instance
    }()
    
    private init() {}
    
    func save(string: String) {
        var array = get()
        array.append(string)
        
        UserDefaults.standard.set(array, forKey: Constants.defaultsKey)
    }
    
    func get() -> [String] {
        if let array = UserDefaults.standard.stringArray(forKey: Constants.defaultsKey) {
            return array
        }
        return [String]()
    }
    
    func delete(string: String) {
        var array = get()
        if let index = array.firstIndex(of: string) {
            array.remove(at: index)
        }
        
        UserDefaults.standard.set(array, forKey: Constants.defaultsKey)
    }
    
}
