//
//  QuotesListView.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

import SwiftUI

struct QuotesListView : View {
    @StateObject private var viewModel = QuotesViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("loading Quotes ...")
                }else if let error = viewModel.errorMessage {
                    VStack (spacing : 16) {
                        Text(error)
                            .font(.headline)
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchQuotes()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }else {
                    List(viewModel.quotes) { quote in
                        VStack(alignment: .leading,spacing: 8) {
                            Text("\(quote.quote)")
                                .font(.body)
                            if let auther  = quote.author {
                                Text("-\(auther)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                    }
                    .refreshable {
                        await viewModel.fetchQuotes()
                    }
                }
            }
            .navigationTitle("Quotes Viewer")
            
        }
        .task {
            await viewModel.fetchQuotes()
        }
    }
}
