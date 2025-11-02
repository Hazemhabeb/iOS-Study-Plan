//
//  MockNetworkService.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import Foundation

final class MockNetworkService : NetworkServiceProtocol {
    var resultData: Data?
    var resultError: NetworkError?
    var delay: TimeInterval =  0 // simulate async behavior
    
    
    func get<T>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            if let error = self.resultError {
                completion(.failure(error))
                return
            }
            guard let data = self.resultData else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
    }
}
