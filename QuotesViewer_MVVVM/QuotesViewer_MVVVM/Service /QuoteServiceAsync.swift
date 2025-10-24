//
//  QuoteServiceAsync.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

import Foundation

protocol QuoteServiceAsyncProtocol {
    func fetchQuotes() async throws -> [Quote]
}

final class QuoteServiceAsync : QuoteServiceAsyncProtocol {
    func fetchQuotes() async throws -> [Quote] {
        let url = URL(string: "https://dummyjson.com/quotes")!
        let (data , _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(QuoteResponse.self, from: data).quotes
    }
}
