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
    @StateObject private var vm = DIContainer.makePostsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onAppear {
                    vm.loadPosts()
                }
        }
    }}
