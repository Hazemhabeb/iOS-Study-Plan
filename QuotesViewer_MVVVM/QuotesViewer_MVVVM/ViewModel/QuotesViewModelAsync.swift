//
//  QuotesViewModelAsync.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//
import Foundation

@MainActor
final class QuotesViewModelAsync : ObservableObject {
    @Published private(set) var quotes : [Quote] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage : String?
    @Published var searchText = ""
    @Published private(set) var filteredQuotes : [Quote] =  []
    
    private let service : QuoteServiceAsyncProtocol
    
    init(service : QuoteServiceAsyncProtocol  = QuoteServiceAsync()) {
        self.service = service
    }
    
    func fetchQuotes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetched = try await service.fetchQuotes()
            quotes = fetched
            filteredQuotes = fetched
        } catch {
            errorMessage = "failed to load quotes"
        }
        isLoading = false
    }
    
    func filterQuotes () {
        guard !searchText.isEmpty else{
            filteredQuotes = quotes
            return
        }
        filteredQuotes = quotes.filter {
            $0.quote.localizedCaseInsensitiveContains(searchText) ||
            ($0.author?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
}
