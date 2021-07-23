//
//  HTTPClient.swift
//  BookStore_Filipe
//
//  Created by FAP on 22/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import Foundation
import Alamofire

final class HTTPClient<T: Decodable> {
    
    func request(with param:[String:String], onComplete: @escaping (Swift.Result<T, Error>) -> (Void)) {
        AF.request(Constants.URL, parameters: param)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(decoded):
                    onComplete(.success(decoded))
                case let .failure(error):
                    onComplete(.failure(error))
                }
        }
    }
    
}
