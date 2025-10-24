//
//  QuotesListViewCombine.swift
//  QuotesViewer_MVVVM
//
//  Created by hazemhabeb on 25/10/2025.
//

import SwiftUI

struct QuotesListViewCombine: View {
    @StateObject private var viewModel = QuotesViewModelCombine()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.filteredQuotes) { quote in
                        VStack(alignment: .leading,spacing: 8) {
                            Text("“\(quote.quote)”")
                            if let author = quote.author {
                                Text("- \(author)").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchQuotes()
                    }
                }
            }
            .navigationTitle("Quotes (Combine)")
        }
        .onAppear {
            viewModel.fetchQuotes()
        }
    }
}

