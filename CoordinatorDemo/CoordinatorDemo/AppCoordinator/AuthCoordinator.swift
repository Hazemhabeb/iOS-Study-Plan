//
//  AuthCoordinator.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

final class AuthCoordinator : Coordinator {
    var navigationController: UINavigationController
    
    private var homeCoordinator: HomeCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginVC()
        loginVC.delegate = self
        navigationController.setViewControllers([loginVC], animated: true)
    }
}

extension AuthCoordinator : LoginVCDelegate {
    
    func loginVCDidTapSignup(_ controller : LoginVC) {
        let signupVC = SignupVC()
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func loginVCDidFinishLogin(_ controller : LoginVC) {
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator?.start()
    }
}
