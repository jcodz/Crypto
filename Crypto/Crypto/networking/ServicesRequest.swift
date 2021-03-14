//
//  CryptoApi.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class ServicesRequest {
    
    public class func callService(with requestModel: Request) {
        
        
        var components = URLComponents(string: requestModel.urlString)
        components?.queryItems = requestModel.queries
        
        guard let url = components?.url,
              let callback = requestModel.onBaseCallback else {
//            requestModel.onBaseCallback(.failure(with: .notFound))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(with: .defaultError))
                return
            }
            
            if let error = error {
                callback(.failure(with:.serverError(error: error)))
            } else if let data = data, response.statusCode == 200 {
                do {
                    callback(.success(data: data))
                } catch {
                    callback(.failure(with: .parserError))
                }
            } else {
                callback(.failure(with: .defaultError))
            }
        }.resume()
    }
}



