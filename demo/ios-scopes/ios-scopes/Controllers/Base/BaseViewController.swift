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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = false
            
            self.view.addSubview(self.loadingSpinner)
            self.loadingSpinner.center = self.view.center
            self.loadingSpinner.startAnimating()
        }
    }
    
    /// Stop a loading animation
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingSpinner.stopAnimating()
            self?.loadingSpinner.removeFromSuperview()
            
            self?.view.isUserInteractionEnabled = true
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
