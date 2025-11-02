//
//  UrlSessionService.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//

import Foundation

final class UrlSessionService : NetworkServiceProtocol {
    private let session : URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get<T : Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void){
        let task = session.dataTask(with: url){ data , response , error in
            // Network error
            if let err = error {
                completion(.failure(.requestFailed(err)))
                return
            }
            //Basic response validation
            guard let http = response as? HTTPURLResponse , 200 ..< 300 ~= http.statusCode , let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            //Decode
            do {
                let decoded  = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    
}
