//
//  DetailViewControllerRepresendable.swift
//  SwiftUIIntegrationDemo
//
//  Created by hazemhabeb on 22/10/2025.
//

import SwiftUI

struct DetailViewControllerRepresendable : UIViewControllerRepresentable {
    let item: Item
    var onDismiss: () -> Void
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = DetailViewController()
        vc.item = item
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onDismiss: onDismiss)
    }
    
    class Coordinator : NSObject, DetailViewControllerDelegate {
        var onDismiss : () -> Void
        
        init(onDismiss: @escaping () -> Void) {
            self.onDismiss = onDismiss
        }
        
        func didDismissDetail() {
            onDismiss()
        }
    }
}
