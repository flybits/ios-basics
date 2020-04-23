//
//  ControlCentreViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit
import FlybitsSDK

class ControlCentreViewController: BaseViewController {
    
    private let disconnectButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        disconnectButton.setTitle("Logout", for: .normal)
        disconnectButton.addTarget(self, action: #selector(disconnect), for: .touchUpInside)
        
        view.addSubview(disconnectButton)
        disconnectButton.pin([
            disconnectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disconnectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func disconnect() {
        FlybitsManager.disconnect { [weak self] jwtToken, error in
            self?.stopLoading()
        }
    }
}
