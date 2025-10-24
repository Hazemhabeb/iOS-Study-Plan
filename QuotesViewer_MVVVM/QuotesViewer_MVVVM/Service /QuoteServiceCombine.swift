//
//  QuoteServiceCombine.swift
//  QuotesViewer_MVVVM
//
//  Created by hazemhabeb on 25/10/2025.
//

import Foundation
import Combine

protocol QuoteServiceCombineProtocol {
    func fetchQuotes() -> AnyPublisher<[Quote] , Error>
}

final class QuoteServiceCombine : QuoteServiceCombineProtocol {
    func fetchQuotes() -> AnyPublisher<[Quote], any Error> {
        let url = URL(string: "https://dummyjson.com/quotes")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: QuoteResponse.self, decoder: JSONDecoder())
            .map(\.quotes)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
