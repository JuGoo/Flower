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
    let myOrdersTabNavigationController = UINavigationController()
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
    
    fileprivate func initAndStartOrderCoordinator(navigationController: UINavigationController) {
        let orderCoordinator = OrderCoordinator(navigationController: navigationController)
        orderCoordinator.delegate = self
        orderCoordinator.start()
        self.addChildCoordinator(orderCoordinator)
    }
    
    fileprivate func initAndStartAuthenticationCoordinator(navigationController: UINavigationController) {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        self.addChildCoordinator(authenticationCoordinator)
    }
    
    fileprivate func initAndStartMyOrdersCoordinator(navigationController: UINavigationController) {
        let myOrdersCoordinator = MyOrdersCoordinator(navigationController: navigationController)
        myOrdersCoordinator.delegate = self
        myOrdersCoordinator.start()
        self.addChildCoordinator(myOrdersCoordinator)
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
        
        initAndStartOrderCoordinator(navigationController: orderTabNavigationController)
        
        let myOrdersTabBarItem = UITabBarItem(title: "My orders", image: UIImage(named: "first"), tag: 1)
        myOrdersTabNavigationController.tabBarItem = myOrdersTabBarItem
        
        initAndStartMyOrdersCoordinator(navigationController: myOrdersTabNavigationController)
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "second"), tag: 2)
        profileTabNavigationController.tabBarItem = profileTabBarItem
        
//        initAndStartOrderCoordinator(navigationController: profileTabNavigationController)
        
        tabBarController?.viewControllers = [orderTabNavigationController, myOrdersTabNavigationController, profileTabNavigationController]
    }
}

extension AppCoordinator: UITabBarControllerDelegate {
    fileprivate func showLoginViewController() {
        initAndStartAuthenticationCoordinator(navigationController: profileTabNavigationController)
    }
    
    fileprivate func showMyOrdersViewController() {
        initAndStartMyOrdersCoordinator(navigationController: myOrdersTabNavigationController)
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
            //my orders
            case controllers[1]:
                showMyOrdersViewController()
                break
                //profile - login
            case controllers[2]:
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

extension AppCoordinator: OrderCoordinatorDelegate {
    func orderCoordinatorDelegateDidLogout(_ orderCoordinator: OrderCoordinator) {
        
        //        UserManager.shared.clearToken()
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        
        profileTabNavigationController.viewControllers = []
        self.removeChildCoordinator(orderCoordinator)
        
        tabBarController?.selectedIndex = 0
    }
}

extension AppCoordinator: MyOrdersCoordinatorDelegate {
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

