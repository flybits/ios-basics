//
//  ScopesViewController.swift
//  ios-basics
//
//  Created by Nuo Xu on 2020-04-15.
//  Copyright © 2020 MikeH. All rights reserved.
//

import Foundation
import UIKit
import FlybitsSDK

class ScopesViewController: UIViewController {
    
    // MARK: - Design
    struct Design {
        static let verticalPadding: CGFloat = 20.0
        static let horizontalPadding: CGFloat = 20.0
        static let buttonHeight: CGFloat = 44.0
    }
    
    private let myScope = MyScope()
    private let stackView = UIStackView()
    private let addScopeButton = UIButton()
    private let connectButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        addScopeButton.backgroundColor = .blue
        addScopeButton.setTitle("Add Your Scope", for: .normal)
        addScopeButton.addTarget(self, action: #selector(onAddScopeButtonTapped), for: .touchUpInside)
        
        updateConnectButton()
        connectButton.addTarget(self, action: #selector(onConnectButtonTapped), for: .touchUpInside)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Design.verticalPadding),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Design.horizontalPadding),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Design.horizontalPadding),
        ])
        
        stackView.addArrangedSubviews([/*addScopeButton ,*/connectButton])
        
        NSLayoutConstraint.activate([
            connectButton.heightAnchor.constraint(equalToConstant: Design.buttonHeight)
        ])
        
        // Add your own `Scope` to `FlybtisManager` so that it can start listen
        FlybitsManager.add(scope: myScope, forkey: "\(MyScope.self)")
    }
    
    deinit {
        // remove the `MyScope`
        FlybitsManager.removeScope(forKey: "\(MyScope.self)")
    }
    
    private func updateConnectButton() {
        if !FlybitsManager.isConnected {
            DispatchQueue.main.async {
                self.connectButton.backgroundColor = .red
                self.connectButton.setTitle("Connect Project", for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.connectButton.backgroundColor = .blue
                self.connectButton.setTitle("Disconnect project", for: .normal)
            }
        }
    }
    
    // MARK: - Actions
    @objc
    private func onAddScopeButtonTapped() {
        // Add your own `Scope` to `FlybtisManager`
        FlybitsManager.add(scope: myScope, forkey: "\(MyScope.self)")
    }
    
    @objc
    private func onConnectButtonTapped() {
        FlybitsManager.environment = FlybitsManager.Environment.productionUS
        if !FlybitsManager.isConnected {
            // create an IDP
            let myIDP = FlybitsIDP(email: "nuo.xu@flybits.com", password: "K2iA3WsF[R")
            // connect Flybits with your IDP and a projectID
            FlybitsManager.connect(myIDP, customerId: "", projectId: "D57EBC96-209B-44F7-88F7-091EF8CEA4B5") { [weak self] user, error in
                self?.updateConnectButton()
            }
        } else {
            FlybitsManager.disconnect { [weak self] jwtToken, error in
                self?.updateConnectButton()
            }
        }
        
    }
}
