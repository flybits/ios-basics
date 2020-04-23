//
//  BaseViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let loadingSpinner = UIActivityIndicatorView(style: .medium)

    /// The rootViewController that this VC belongs to
     var rootController: RootViewController {
        return (view.window?.windowScene?.delegate as! SceneDelegate).rootController!
     }
    
    // MARK: - Public
    
    /// Start a loading animation
    func startLoading() {
        view.isUserInteractionEnabled = false
        
        view.addSubview(loadingSpinner)
        loadingSpinner.center = view.center
        loadingSpinner.startAnimating()
    }
    
    /// Stop a loading animation
    func stopLoading() {
        self.loadingSpinner.stopAnimating()
        self.loadingSpinner.removeFromSuperview()
        
        view.isUserInteractionEnabled = true
    }
}
