//
//  QuotesListView.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

import SwiftUI

struct QuotesListViewAsync : View {
    @StateObject private var viewModel = QuotesViewModelAsync()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search ...",text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: viewModel.searchText){ _ in
                        viewModel.filterQuotes()
                    }
                if viewModel.isLoading {
                    ProgressView("loading ...")
                }else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }else {
                    List(viewModel.filteredQuotes) { quote in
                        VStack(alignment: .leading,spacing: 8 ){
                            Text("\(quote.quote)")
                                .font(.headline)
                            if let auther = quote.author {
                                Text("-\(auther)")
                                    .font(.caption)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchQuotes()
                    }
                }
            }
            .navigationTitle("Quotes (Async)")
        }
        .task {
            await viewModel.fetchQuotes()
        }
    }
}
