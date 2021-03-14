//
//  CryptoApi.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class ServicesRequest {
    
    public class func callService(with requestModel: Request) {
        
        guard var components = URLComponents(string: cryptoRequest.urlString),
              let url = components.url else {
            completion(.failure(with: .notFound))
            return
        }
        
        components.queryItems = cryptoRequest.queries
        
        var request = URLRequest(url: url)
        request.httpMethod = cryptoRequest.method
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                requestModel.onBaseCallback(.failure(with: .defaultError))
                return
            }
            
            if let error = error {
                requestModel.onBaseCallback(.serverError(error: error))
            } else if let data = data, response.statusCode == 200 {
                do {
                    let entries = try self.decodeResponse(data: data)
                    requestModel.onBaseCallback(.success(entries: entries))
                } catch {
                    requestModel.onBaseCallback(.failure(with: .parserError))
                }
            } else {
                requestModel.onBaseCallback(.failure(with: .defaultError))
            }
        }.resume()
    }
}

extension ServicesRequest {
    fileprivate func decodeResponse(data: Data) throws -> [CryptoEntryDto]{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try decoder.decode([CryptoEntryDto].self, from: data)
        return response
    }
}
