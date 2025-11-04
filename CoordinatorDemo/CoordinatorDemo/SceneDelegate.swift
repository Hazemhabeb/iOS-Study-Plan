//
//  SceneDelegate.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let coordinator = AppCoordinator(window: window)
        self.appCoordinator = coordinator
        coordinator.start()
        
        
        self.window = window
    }


}


