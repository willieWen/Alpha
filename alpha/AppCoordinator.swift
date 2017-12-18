//
//  AppCoordinator.swift
//  alpha
//
//  Created by william on 4/9/17.
//  Copyright © 2017 EWApps. All rights reserved.
//
/*
import UIKit

class appCoordinator : NSObject {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    private func constructAunthenticatedRootViewController() -> UIViewController {
        let homepageController = HomePageController()
            let homePage = UINavigationController(rootViewController: homepageController)
    
        let profile = UIViewController()
            profile.view.backgroundColor = .red
    
        let availability = UIViewController()
            availability.view.backgroundColor = .blue
    
        let roster = UIViewController()
            roster.view.backgroundColor = .yellow
    
        let controllers = [
            homePage,
            profile,
            availability,
            roster
            ]
    
        let tabBarController = UITabBarController()
            tabBarController.viewControllers = controllers
            tabBarController.selectedViewController = homePage
    
    return tabBarController
}
} */
