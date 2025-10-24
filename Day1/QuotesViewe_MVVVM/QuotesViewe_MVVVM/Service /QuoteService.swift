//
//  QuoteService.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

import Foundation

protocol QuoteServiceProtocol {
    func fetchQuotes() async throws -> [Quote]
}

final class QuoteService : QuoteServiceProtocol {
    func fetchQuotes() async throws -> [Quote] {
        let url = URL(string: "https://dummyjson.com/quotes?limit=30")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(QuoteResponse.self, from: data).quotes
    }
}
