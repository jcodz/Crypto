//
//  CryptoApi.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class ServicesRequest {
    
    public class func callService(with requestModel: Request) {
        
        guard var components = URLComponents(string: requestModel.urlString),
              let url = components.url,
              let callback = requestModel.onBaseCallback else {
//            requestModel.onBaseCallback(.failure(with: .notFound))
            return
        }
        
        components.queryItems = requestModel.queries
        
        var request = URLRequest(url: url)
        request.httpMethod = requestModel.method
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(with: .defaultError))
                return
            }
            
            if let error = error {
                callback(.failure(with:.serverError(error: error)))
            } else if let data = data, response.statusCode == 200 {
                do {
                    let entries = try ServicesRequest.decodeResponse(data: data)
                    callback(.success(entries: entries))
                } catch {
                    callback(.failure(with: .parserError))
                }
            } else {
                callback(.failure(with: .defaultError))
            }
        }.resume()
    }
}

extension ServicesRequest {
    fileprivate static func decodeResponse(data: Data) throws -> [CryptoEntryDto]{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try decoder.decode(CryptoEntriesDto.self, from: data)
        return response.payload
    }
}
