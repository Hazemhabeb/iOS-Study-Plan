//
//  LoginVC.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

protocol LoginVCDelegate : AnyObject {
    func loginVCDidTapSignup(_ controller : LoginVC)
    func loginVCDidFinishLogin(_ controller : LoginVC)
}

final class LoginVC : UIViewController {
    weak var delegate : LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        view.backgroundColor = .systemBackground
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Go To Sigup", for: .normal)
        signupButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        
        
        let stack = UIStackView(arrangedSubviews: [loginButton,signupButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapLogin(){
        delegate?.loginVCDidFinishLogin(self)
    }
    
    @objc private func didTapSignup(){
        delegate?.loginVCDidTapSignup(self)
    }
}
