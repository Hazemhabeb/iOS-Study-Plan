//
//  DI_PracticeApp.swift
//  DI_Practice
//
//  Created by hazemhabeb on 02/11/2025.
//

import SwiftUI

@main
struct DI_PracticeApp: App {
    // Use factory to create view model
//    @StateObject private var vm = DIContainer.makePostsViewModel()
    //Resolve ViewModel via Swinject
    @StateObject private var vm = AppAssembly.shared.resolve(PostsViewModel.self)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onAppear {
                    vm.loadPosts()
                }
        }
    }}
