//
//  QuotesViewModel.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

import Foundation

@MainActor
final class QuotesViewModel : ObservableObject {
    @Published private(set) var quotes : [Quote] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage : String?
    
    private let service : QuoteServiceProtocol
    
    init(service : QuoteServiceProtocol = QuoteService()) {
        self.service = service
    }
    
    func fetchQuotes () async {
        isLoading = true
        errorMessage = nil
        
        do {
            quotes = try await service.fetchQuotes()
        } catch {
            errorMessage = "failed load quotes , please try again."
        }
        isLoading = false
    }
}
