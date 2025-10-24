//
//  QuotesViewModelCombine.swift
//  QuotesViewer_MVVVM
//
//  Created by hazemhabeb on 25/10/2025.
//

import Foundation
import Combine

final class QuotesViewModelCombine : ObservableObject {
    @Published private(set) var quotes : [Quote] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage : String?
    @Published var searchText = ""
    @Published private(set) var filteredQuotes : [Quote] = []
    
    private let service : QuoteServiceCombineProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service : QuoteServiceCombineProtocol = QuoteServiceCombine()){
        self.service = service
        setupSearchPipeline()
    }
    
    func fetchQuotes() {
        isLoading = true
        errorMessage = nil
        
        service.fetchQuotes()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.errorMessage = "failed to load quotes"
                }
            }, receiveValue: { [weak self] fetched  in
                self?.quotes = fetched
                self?.filteredQuotes = fetched
            })
            .store(in: &cancellables)
    }
    
    func setupSearchPipeline() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .combineLatest($quotes)
            .map { search , quotes in
                guard !search.isEmpty else{return quotes }
                
                return quotes.filter{
                    $0.quote.localizedCaseInsensitiveContains(search) ||
                    ($0.author?.localizedCaseInsensitiveContains(search) ?? false)
                }
            }
            .assign(to: &$filteredQuotes)
    }
}
