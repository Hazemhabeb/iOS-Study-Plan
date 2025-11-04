//
//  Coordinator.swift
//  CoordinatorDemo
//
//  Created by hazemhabeb on 04/11/2025.
//
import UIKit

protocol Coordinator : AnyObject {
    var navigationController : UINavigationController { get set }
    func start()
}
