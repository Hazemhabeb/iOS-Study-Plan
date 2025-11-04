//
//  HomeCoordinator.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

final class HomeCoordinator : Coordinator {
    var navigationController: UINavigationController
    
    private var authCoordinator: AuthCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeVC()
        homeVC.delegate = self
        navigationController.setViewControllers([homeVC], animated: true)
    }
}
extension HomeCoordinator : HomeVCDelegate {
    
    func homeVCDidSelectDetails(_ controller: HomeVC) {
        let detailsVC = DetailsVC()
        navigationController.pushViewController(detailsVC, animated: true)
    }
    
    func homeVCDidTapLogout(_ controller: HomeVC) {
        authCoordinator = AuthCoordinator(navigationController : navigationController)
        authCoordinator?.start()
    }
}
