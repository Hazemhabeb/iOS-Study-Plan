//
//  ItemListView.swift
//  SwiftUIIntegrationDemo
//
//  Created by hazemhabeb on 22/10/2025.
//

import SwiftUI

struct ItemListView : View {
    @State private var items = [
        Item(id: 1, title: "UIKit"),
        Item(id: 2, title: "SwiftUI"),
        Item(id: 3, title: "Jetpack")
    ]
    @State private var seletedItem : Item?
    @State private var showDetail  = false
    
    var body: some View {
        NavigationView{
            List(items) { item in
                Button {
                    seletedItem = item
                    showDetail = true
                } label: {
                    Text(item.title)
                        .font(.headline)
                }
            }
            .navigationTitle("Items")
            .sheet(isPresented: $showDetail){
                if let seletedItem = seletedItem {
                    DetailViewControllerRepresendable(item: seletedItem) {
                        showDetail = false
                    }
                }
            }
        }
    }
}
