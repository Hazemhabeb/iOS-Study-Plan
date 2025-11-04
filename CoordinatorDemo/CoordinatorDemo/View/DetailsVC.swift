//
//  DetailsVC.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

final class DetailsVC : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .systemGray6
        
        let label = UILabel()
        label.text = "Details Screen"
        label.font = UIFont.systemFont(ofSize: 24,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
