//
//  NetworkService.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchQuotes() async throws -> [Quote]
}

final class NetworkService : NetworkServiceProtocol {
    
    func fetchQuotes() async throws -> [Quote] {
        guard let url = URL(string: "https://dummyjson.com/quotes") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(QuoteResponse.self, from: data).quotes
    }
}
