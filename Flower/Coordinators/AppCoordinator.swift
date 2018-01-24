//
//  AppCoordinator.swift
//  AccorBooking
//
//  Created by Julien Gourdet on 16/01/2018.
//  Copyright © 2018 JG. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
}

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController? { get set }
    init(tabBarController: UITabBarController?)
}

class AppCoordinator: NSObject, TabBarCoordinator {
    
    var isLoggedIn = false
    
    var tabBarController: UITabBarController?
    var childCoordinators = [Coordinator]()
    
    let orderTabNavigationController = UINavigationController()
    let profileTabNavigationController = UINavigationController()
    
    required init(tabBarController: UITabBarController?) {
        self.tabBarController = tabBarController
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func start() {
        tabBarController?.delegate = self
        initTabBarController()
    }
    
    fileprivate func initAndStartMainCoordinator(navigationController: UINavigationController) {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        mainCoordinator.start()
        self.addChildCoordinator(mainCoordinator)
    }
    
    fileprivate func initAndStartAuthenticationCoordinator(navigationController: UINavigationController) {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        self.addChildCoordinator(authenticationCoordinator)
    }
    
    fileprivate func initAndStartProfileCoordinator(navigationController: UINavigationController) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.delegate = self
        profileCoordinator.start()
        self.addChildCoordinator(profileCoordinator)
    }
    
    fileprivate func initTabBarController() {
        
        let orderTabBarItem = UITabBarItem(title: "Order", image: UIImage(named: "first"), tag: 0)
        orderTabNavigationController.tabBarItem = orderTabBarItem
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "second"), tag: 1)
        profileTabNavigationController.tabBarItem = profileTabBarItem
        
        initAndStartMainCoordinator(navigationController: orderTabNavigationController)
        
        tabBarController?.viewControllers = [orderTabNavigationController, profileTabNavigationController]
    }
}

extension AppCoordinator: UITabBarControllerDelegate {
    fileprivate func showLoginViewController() {
        initAndStartAuthenticationCoordinator(navigationController: profileTabNavigationController)
    }
    
    fileprivate func showProfileViewController() {
        initAndStartProfileCoordinator(navigationController: profileTabNavigationController)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let controllers = tabBarController.viewControllers {
            switch viewController {
                //orders
            case controllers[0]:
                break
                //profile - login
            case controllers[1]:
                // user is not logged in and Profile tab is selected
                if !isLoggedIn {
                    showLoginViewController()
                } else {
                    showProfileViewController()
                }
                break
            default:
                break
            }
        }
        return true
    }
}

extension AppCoordinator: MainCoordinatorDelegate {
    func mainCoordinatorDelegateDidLogout(_ mainCoordinator: MainCoordinator) {
        
        //        UserManager.shared.clearToken()
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        
        profileTabNavigationController.viewControllers = []
        self.removeChildCoordinator(mainCoordinator)
        
        tabBarController?.selectedIndex = 0
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    
    func coordinatorDidAuthenticate(coordinator: AuthenticationCoordinator) {
        self.isLoggedIn = true
        showProfileViewController()
    }
    
    func coordinatorDidCreateAccount(coordinator: AuthenticationCoordinator) {
        showLoginViewController()
    }
}

extension AppCoordinator: ProfileCoordinatorDelegate {
    
    func coordinatorLogout(coordinator: ProfileCoordinator) {
        self.isLoggedIn = false
        showLoginViewController()
    }
}

