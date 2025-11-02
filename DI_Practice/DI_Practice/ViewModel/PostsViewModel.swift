
//
//  PostsViewModel.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import Foundation
import Combine

final class PostsViewModel : ObservableObject {
    @Published private(set) var posts : [Post] = []
    @Published private(set) var isLoading : Bool = false
    @Published private(set) var errorMessage : String?
    
    private let repository : PostRepositoryProtocol
    private let cancallables = Set<AnyCancellable>()
    
    init(repository : PostRepositoryProtocol){
        self.repository = repository
    }
    
    func loadPosts () {
        isLoading = true
        errorMessage = nil
        repository.fetchPosts{ [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let postResponse) :
                    self.posts = postResponse.posts
                    print("posts \(self.posts)")
                case .failure(let error) :
                    self.errorMessage = "Failed : \(error)"
                    print("error : \(error)")
                }
            }
        }
    }
    
}
