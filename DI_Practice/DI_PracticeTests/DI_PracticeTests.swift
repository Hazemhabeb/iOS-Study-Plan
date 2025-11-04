//
//  DI_PracticeTests.swift
//  DI_PracticeTests
//
//  Created by hazemhabeb on 02/11/2025.
//

import XCTest
@testable import DI_Practice

final class DI_PracticeTests: XCTestCase {
    
    func test_loadPosts_withMockData_succeeds() {
        //Arrage
        let mockService = MockNetworkService()
        
        let samplePosts = [
            Post(userId: 1, id: 1, title: "mock title", body: "Mock body")
        ]
        let postResponse = PostResponse(posts: samplePosts, total: 1, skip: 1, limit: 1)
        mockService.resultData = try! JSONEncoder().encode(postResponse)
        
        let vm = DIContainer.makePostsViewModel(newtworkService: mockService)
        let expect = expectation(description: "posts loaded")
        
        //Act
        vm.loadPosts()
        
        //Assertion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(vm.posts.count, 1)
            XCTAssertEqual(vm.posts.first?.title, "mock title")
            XCTAssertFalse(vm.isLoading)
            XCTAssertNil(vm.errorMessage)
            print("[unit test] mock injection succeeded -> posts :", vm.posts)
            expect.fulfill()
        }
        
        wait(for: [expect],timeout: 1.0)
    }
    
    func test_loadPosts_withMockError_fails() {
        let mockService = MockNetworkService()
        mockService.resultError = .invalidResponse
        
        let vm = DIContainer.makePostsViewModel(newtworkService: mockService)
        let expect = expectation(description: "error deliveered")
        
        vm.loadPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(vm.posts.isEmpty)
            XCTAssertNotNil(vm.errorMessage)
            print("[unit test] mock injection produced error :", vm.errorMessage ?? "")
            expect.fulfill()
        }
        wait(for: [expect] ,timeout: 1.0)
    }
    
    func test_mock_injection_succeeds() {
        let mockService = MockNetworkService()
        let samplePosts = [
            Post(userId: 1, id: 1, title: "mock title", body: "Mock body")
        ]
        let postResponse = PostResponse(posts: samplePosts, total: 1, skip: 1, limit: 1)
        mockService.resultData = try! JSONEncoder().encode(postResponse)
        
        //Register mock instead of real network
        AppAssembly.shared.registerMockDependencies(mockService)
        
        let vm = AppAssembly.shared.resolve(PostsViewModel.self)
        let expect = expectation(description: "mock posts loaded")
        
        vm.loadPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            XCTAssertEqual(vm.posts.count, 1)
            XCTAssertEqual(vm.posts.first?.title, "mock title")
            print("[MockInjection] success 💥")
            expect.fulfill()
        }
        wait(for: [expect],timeout: 1)
    }
}
