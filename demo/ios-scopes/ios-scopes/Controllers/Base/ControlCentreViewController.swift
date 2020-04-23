//
//  ControlCentreViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit
import FlybitsSDK

class ControlCentreViewController: BaseViewController, FlybitsScope {

    // MARK: - Constants
    struct Constants {
        static let defaultCellIdentifier = "defaultCellIdentifier"
        static let controlCentreCellIdentifier = "controlCentreCellIdentifier"
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var isFlybitsAccountOptedIn = true
    
    deinit {
        FlybitsManager.removeScope(forKey: "\(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTheme()
        registerClasses()
        doLayout()
        
        FlybitsManager.add(scope: self, forkey: "\(self)")
    }
    
    private func setTheme() {
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "CONTROLS"
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerClasses() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellIdentifier)
        collectionView.register(ControlCentreCell.self, forCellWithReuseIdentifier: Constants.controlCentreCellIdentifier)
    }
    
    private func doLayout() {
        view.addSubview(collectionView)
        collectionView.pinToSuperView()
    }
    
    // MARK: - FlybitsScope
    
    var identifier: String = UUID().uuidString
    
    func onConnected(user: User) {
        isFlybitsAccountOptedIn = user.isOptedIn
    }
    
    func onDisconnected(jwtToken: String) {}
    
    func onAccountDestroyed(jwtToken: String) {}
    
    func onOptIn() {
        DispatchQueue.main.async {
            self.isFlybitsAccountOptedIn = true
            self.collectionView.reloadData()
        }
    }
    
    func onOptOut() {
        DispatchQueue.main.async {
            self.isFlybitsAccountOptedIn = false
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ControlCentreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.controlCentreCellIdentifier, for: indexPath) as? ControlCentreCell {
                cell.viewModel = ControlCentreCell.ControlCentreCellViewModel(title: isFlybitsAccountOptedIn ? "Opt Out" : "Opt In")
                cell.backgroundColor = .optInOutCellColor
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.controlCentreCellIdentifier, for: indexPath) as? ControlCentreCell {
                cell.viewModel = ControlCentreCell.ControlCentreCellViewModel(title: "Logout")
                cell.backgroundColor = .logoutCellColor
                
                return cell
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            startLoading()
            
            if isFlybitsAccountOptedIn {
                FlybitsManager.optOut { [weak self] error in
                    if let error = error {
                        self?.showError(error)
                    }
                    
                    self?.stopLoading()
                }
            } else {
                FlybitsManager.optIn { [weak self] error in
                    if let error = error {
                        self?.showError(error)
                    }
                    
                    self?.stopLoading()
                }
            }
        } else {
            startLoading()
            
            FlybitsManager.disconnect { [weak self] jwtToken, error in
                if let error = error {
                    self?.showError(error)
                }
                self?.stopLoading()
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ControlCentreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsects = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        
        return CGSize(width: collectionView.frame.width - sectionInsects.left - sectionInsects.right, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
}
