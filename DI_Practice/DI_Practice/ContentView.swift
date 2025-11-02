//
//  ContentView.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: PostsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Loading posts...")
                } else if let err = vm.errorMessage {
                    VStack(spacing: 16) {
                        Text(err).foregroundColor(.red).multilineTextAlignment(.center)
                        Button("Retry") {
                            vm.loadPosts()
                        }
                    }.padding()
                } else {
                    List(vm.posts) { post in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(post.title).font(.headline)
                            Text(post.body).font(.subheadline).foregroundColor(.secondary)
                        }.padding(.vertical, 6)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        vm.loadPosts()
                    }
                }
            }
            .navigationTitle("DI Practice Posts")
        }
    }
}

