//
//  AppContainer.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Swinject
import Foundation

final class AppContainer {
    static let shared = AppContainer()
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(NetworkServiceProtocol.self){ _ in
            NetworkService()
        }
        
        container.register(CashManager<[Quote]>.self) { _ in
            CashManager<[Quote] >()
        }
        
        container.register(QuotesRepository.self) { r in
            QuotesRepository(
                network: r.resolve(NetworkServiceProtocol.self)!,
                cashe: r.resolve(CashManager<[Quote]>.self)!
            )
        }
        
        container.register(QuotesViewModel.self) { r in
            MainActor.assumeIsolated {
                QuotesViewModel(repository: r.resolve(QuotesRepository.self)!)
            }
        }
    }
}
