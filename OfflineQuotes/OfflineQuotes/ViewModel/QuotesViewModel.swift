//
//  QuotesViewModel.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Combine
import Foundation

@MainActor
final class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var error: AppError?
    @Published var isLoading = false

    private let repository: QuotesRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: QuotesRepository) {
        self.repository = repository
    }

    func loadQuotes(forceRefresh: Bool = false) {
        isLoading = true
        Task {
            do {
                let quotes = try await repository.getQuotes(forceRefresh: forceRefresh)
                await MainActor.run {
                    self.quotes = quotes
                    self.error = nil
                    self.isLoading = false
                }
            } catch let err as AppError {
                await MainActor.run {
                    self.error = err
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = .unknow(error)
                    self.isLoading = false
                }
            }
        }
    }
}
