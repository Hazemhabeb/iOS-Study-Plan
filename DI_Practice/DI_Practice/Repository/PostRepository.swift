//
//  PostRepository.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import Foundation

protocol PostRepositoryProtocol {
    func fetchPosts(completion :@escaping (Result<PostResponse,NetworkError>) -> Void )
}

final class PostRepository : PostRepositoryProtocol {
    private let networkService : NetworkServiceProtocol
    private let postsURL = URL(string: "https://dummyjson.com/posts")!
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPosts(completion: @escaping (Result<PostResponse, NetworkError>) -> Void) {
        networkService.get(url: postsURL, completion: completion)
    }
    
    
    
    
}
