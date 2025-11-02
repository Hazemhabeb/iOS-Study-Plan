//
//  DIContainer.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import Foundation


final class DIContainer {
    //shared factory for the app (simple)
    static func makePostsViewModel() -> PostsViewModel {
        let network = UrlSessionService(session: .shared)
        let repository = PostRepository(networkService: network)
        return PostsViewModel(repository: repository)
    }
    
    //for testing or preview : inject mock service
    static func makePostsViewModel(newtworkService : NetworkServiceProtocol) -> PostsViewModel {
        let repository = PostRepository(networkService: newtworkService)
        return PostsViewModel(repository: repository)
    }
    
}
