//
//  AppAssembly.swift
//  DI_Practice
//
// Created by hazemhabeb on 04/11/2025.
//
import Foundation
import Swinject

final class AppAssembly {
    static let shared = AppAssembly()
    
    private let container : Container
    
    init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies(){
        //MARK: - network layer
        container.register(NetworkServiceProtocol.self) { _ in
            UrlSessionService(session: .shared)
        }.inObjectScope(.container)
        
        //MARK: - Repository
        container.register(PostRepositoryProtocol.self) { r in
            let network = r.resolve(NetworkServiceProtocol.self)!
            return PostRepository(networkService: network)
        }
        
        //MARK: - ViewModel
        container.register(PostsViewModel.self) { r in
            let repo = r.resolve(PostRepositoryProtocol.self)!
            return PostsViewModel(repository: repo)
        }
    }
    
    /// Resolver helper
    func resolve <T> (_ type :T.Type) -> T{
        guard let service = container.resolve(type) else {
            fatalError("Dependency of type \(type) not registered!")
        }
        return service
    }

    ///For testing or previews . we can override dependencies
    func registerMockDependencies(_ mockNetwork :NetworkServiceProtocol){
        container.register(NetworkServiceProtocol.self) {_ in
            mockNetwork
        }.inObjectScope(.transient)
    }
}
