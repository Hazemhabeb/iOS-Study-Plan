//
//  HomeVC.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//

import UIKit

protocol HomeVCDelegate : AnyObject {
    func homeVCDidSelectDetails(_ controller : HomeVC)
    func homeVCDidTapLogout(_ controller : HomeVC)
}

final class HomeVC : UIViewController {
    weak var delegate : HomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        
        let detailsButton = UIButton(type: .system)
        detailsButton.setTitle("Go to Details", for: .normal)
        detailsButton.addTarget(self, action: #selector(goToDetails), for: .touchUpInside)
        
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        
        let stack = UIStackView(arrangedSubviews: [detailsButton,logoutButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func goToDetails() {
        delegate?.homeVCDidSelectDetails(self)
    }
    
    @objc private func logout(){
        delegate?.homeVCDidTapLogout(self)
    }
}
