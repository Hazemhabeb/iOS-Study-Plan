//
//  QuotesViewModel.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Foundation

@MainActor
final class QuotesViewModel : ObservableObject {
    @Published var quotes : [Quote] = []
    @Published var isLoading = false
    @Published var errorMessage : String?
    
    private let repository : QuotesRepository
    
    init(repository : QuotesRepository){
        self.repository = repository
    }
    
    func loadQuotes(forceRefresh : Bool = false) async {
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            let quotes = try await repository.getQuotes(forceRefresh: forceRefresh)
            self.quotes = quotes
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
    }
    
}
