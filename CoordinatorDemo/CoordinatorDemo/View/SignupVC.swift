//
//  SignupVC.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//

import UIKit

final class SignupVC : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Signup"
        view.backgroundColor = .systemGray5
        
        let label = UILabel()
        label.text = "Signup Screen"
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
