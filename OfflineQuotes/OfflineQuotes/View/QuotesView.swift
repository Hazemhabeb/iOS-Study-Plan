//
//  QuotesView.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//

import SwiftUI

struct QuotesView : View {
    @StateObject private var viewModel = AppContainer.shared.container.resolve(QuotesViewModel.self)!
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.error {
                    VStack(spacing: 10) {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.loadQuotes(forceRefresh: true)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(viewModel.quotes) { quote in
                        VStack (alignment: .leading, spacing: 6) {
                            Text(quote.text)
                                .font(.headline)
                            
                            if let auther = quote.auther {
                                Text(auther)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.vertical,4)
                    }
                }
            }
            .overlay{
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .navigationTitle("Offline Quotes")
            .refreshable {
                viewModel.loadQuotes(forceRefresh: true)
            }
            .onAppear {
                viewModel.loadQuotes()
            }
        }
    }
}
