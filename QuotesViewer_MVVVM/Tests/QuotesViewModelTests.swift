//
//  QuotesViewModelTests.swift
//  QuotesViewer_MVVVM
//
//  Created by hazemhabeb on 25/10/2025.
//

import XCTest
@testable import QuotesViewer_MVVVM

class QuotesViewModelTests : XCTestCase {
    
    final class MockServiceAsyncProtocol : QuoteServiceAsyncProtocol{
        var shouldFail = false
        func fetchQuotes() async throws -> [QuotesViewer_MVVVM.Quote] {
            if shouldFail { throw URLError(.badServerResponse) }
            return [Quote(quote: "test", author: "hazem")]
        }
    }
    
    func test_fetchQuotes_success() async{
        let service = MockServiceAsyncProtocol()
        let viewModel = await MainActor.run { QuotesViewModelAsync(service: service) }
        
        await viewModel.fetchQuotes()
        await MainActor.run {
            XCTAssertFalse(viewModel.quotes.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
        }
        
    }
    
    func test_fetchQuotes_failure() async {
        let service = MockServiceAsyncProtocol()
        service.shouldFail = true
        let viewModel = await MainActor.run { QuotesViewModelAsync(service: service) }
        
        await viewModel.fetchQuotes()
        await MainActor.run {
            XCTAssertTrue(viewModel.quotes.isEmpty)
            XCTAssertNotNil(viewModel.errorMessage)
        }
        
    }
}
