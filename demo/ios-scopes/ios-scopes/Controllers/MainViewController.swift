//
//  MainViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-21.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit
import FlybitsSDK
import FlybitsConciergeSDK

enum TabControllerId: String {
    case home = "HOME"
    case controlCentre = "CONTROLS"
    case concierge = "CONCIERGE"
}

class MainViewController: UITabBarController, FlybitsScope {
    
    private var controllers = [UIViewController]()
    private var controllerIds = [TabControllerId]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initControls()
        setTheme()
        addScope()
    }
    
    private func initControls() {
        var tabTitles = [String]()
        var tabImages = [UIImage]()
        let homeController = HomeViewController()
        
        if FlybitsManager.isConnected {
            tabTitles.append(contentsOf: [TabControllerId.home.rawValue, TabControllerId.controlCentre.rawValue, TabControllerId.concierge.rawValue])
            tabImages.append(contentsOf: [#imageLiteral(resourceName: "Home"), #imageLiteral(resourceName: "ControlCentre"), #imageLiteral(resourceName: "Concierge")])
            
            let controlCentreVC = ControlCentreViewController()
            let conciergeVC = FlybitsConciergeManager.conciergeViewController(for: "D57EBC96-209B-44F7-88F7-091EF8CEA4B5", using: "", display: [.displayMode: DisplayMode.navigation], callback: nil)
            
            controllers.append(contentsOf: [homeController, controlCentreVC, conciergeVC])
            controllerIds.append(contentsOf: [.home, .controlCentre, .concierge])
        } else {
            tabTitles.append(TabControllerId.home.rawValue)
            tabImages.append(#imageLiteral(resourceName: "Home"))
            
            controllers.append(homeController)
            controllerIds.append(.home)
        }
        
        for (index, controller) in controllers.enumerated() {
            controller.tabBarItem.title = tabTitles[index]
            controller.tabBarItem.image = tabImages[index]

            if index == 0 {
            controller.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10.0, weight: .bold), .foregroundColor: UIColor.black], for: .normal)
            } else {
            controller.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10.0, weight: .regular), .foregroundColor: UIColor.black], for: .normal)
            }
          
            if controllerIds[index] == .concierge {
                controllers[index] = controller
            } else {
                controllers[index] = UINavigationController(rootViewController: controller)
            }
        }
    }
    
    private func setTheme() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        view.backgroundColor = .white
        viewControllers = controllers
        delegate = self
    }
    
    private func addScope() {
        // Add your own `Scope` to `FlybtisManager` so that it can start listen
        FlybitsManager.add(scope: self, forkey: "\(self)")
    }
    
    deinit {
        // remove the `MyScope`
        FlybitsManager.removeScope(forKey: "\(self)")
    }
    
    // MARK: - FlybitsScope
    
    var identifier: String = UUID().uuidString
    
    func onConnected(user: User) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let controlCentreVC = ControlCentreViewController()
            controlCentreVC.tabBarItem.title = TabControllerId.controlCentre.rawValue
            controlCentreVC.tabBarItem.image = #imageLiteral(resourceName: "ControlCentre")
            
            let conciergeVC = FlybitsConciergeManager.conciergeViewController(for: "D57EBC96-209B-44F7-88F7-091EF8CEA4B5", using: "", display: [.displayMode: DisplayMode.navigation], callback: nil)
            conciergeVC.tabBarItem.title = TabControllerId.concierge.rawValue
            conciergeVC.tabBarItem.image = #imageLiteral(resourceName: "Concierge")
            
            self.controllers.append(contentsOf: [UINavigationController(rootViewController: controlCentreVC), conciergeVC])
            self.controllerIds.append(contentsOf: [.controlCentre, .concierge])
            
            self.viewControllers = self.controllers
        }
    }
    
    func onDisconnected(jwtToken: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.controllers.count > 1 {
                self.controllers.removeLast(2)
                self.controllerIds.removeLast(2)
                self.viewControllers = self.controllers
            }
        }
    }
    
    func onAccountDestroyed(jwtToken: String) {
    }
    
    func onOptIn() {
    }
    
    func onOptOut() {
    }
}

// MARK: - UITabBarControllerDelegate

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = tabBar.items {
            for tab in items {
              tab.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10.0, weight: .regular), .foregroundColor: UIColor.gray], for: .normal)
            }
            
          item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10.0, weight: .bold), .foregroundColor: UIColor.black], for: .normal)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
      navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
    }
}
