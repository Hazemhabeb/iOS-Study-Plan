//
//  AppCoordinator.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

final class AppCoordinator : Coordinator {
    var navigationController: UINavigationController
    private let window : UIWindow
    
    private var homeCoordinator: HomeCoordinator?
    
    init(window : UIWindow){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        homeCoordinator = HomeCoordinator(navigationController : navigationController)
        homeCoordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

    }
    
    
}
