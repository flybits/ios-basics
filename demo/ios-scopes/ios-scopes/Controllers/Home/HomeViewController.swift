//
//  HomeViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-21.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit
import FlybitsSDK

class HomeViewController: BaseViewController {
    
    private let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTheme()
        doLayout()
    }
    

    private func setTheme() {
        view.backgroundColor = .white
        
        loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        updateLoginButton()
    }
    
    private func doLayout() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40.0)
        ])
    }
    
    private func updateLoginButton() {
        if !FlybitsManager.isConnected {
            DispatchQueue.main.async {
                self.loginButton.backgroundColor = .red
                self.loginButton.setTitle("Connect Project", for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.loginButton.backgroundColor = .blue
                self.loginButton.setTitle("Disconnect project", for: .normal)
            }
        }
    }
    
    @objc
    private func onLoginButtonTapped() {
        FlybitsManager.environment = FlybitsManager.Environment.productionUS
        
        // start loading
        startLoading()
        
        if !FlybitsManager.isConnected {    // connect

            // create an IDP
            let myIDP = FlybitsIDP(email: "nuo.xu@flybits.com", password: "K2iA3WsF[R")
            // connect Flybits with your IDP and a projectID
            FlybitsManager.connect(myIDP, customerId: "", projectId: "D57EBC96-209B-44F7-88F7-091EF8CEA4B5") { [weak self] user, error in
                self?.updateLoginButton()
                // stop loading
                self?.stopLoading()
            }
        } else {    // disconnect
            FlybitsManager.disconnect { [weak self] jwtToken, error in
                self?.updateLoginButton()
                // stop loading
                self?.stopLoading()
            }
        }
    }
}
