//
//  NetworkServiceProtocol.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//

import Foundation

enum NetworkError : Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

protocol NetworkServiceProtocol {
    func get<T : Decodable>(url:URL, completion: @escaping (Result<T , NetworkError>) -> Void)
}
