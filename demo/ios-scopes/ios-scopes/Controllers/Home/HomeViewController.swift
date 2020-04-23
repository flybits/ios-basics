//
//  HomeViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-21.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit
import FlybitsSDK

class HomeViewController: BaseViewController, FlybitsScope {
    
    // MARK: - Constants
    struct Constants {
        static let defaultCellIdentifier = "defaultCellIdentifier"
        static let homeOfflineCellIdentifier = "homeOfflineCellIdentifier"
        static let homeLoginCellIdentifier = "homeLoginCellIdentifier"
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let dataSource = HomeDataSource()
    
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
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerClasses() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellIdentifier)
        collectionView.register(HomeOfflineCell.self, forCellWithReuseIdentifier: Constants.homeOfflineCellIdentifier)
        collectionView.register(HomeLoginCell.self, forCellWithReuseIdentifier: Constants.homeLoginCellIdentifier)
    }
    
    private func doLayout() {
        view.addSubview(collectionView)
        collectionView.pin(to: view, padding: UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0))
    }
    
    // MARK: - FlybitsScope
    var identifier: String = UUID().uuidString
    
    func onConnected(user: User) {}
    
    func onDisconnected(jwtToken: String) {
        collectionView.reloadData()
    }
    
    func onAccountDestroyed(jwtToken: String) {}
    
    func onOptIn() {}
    
    func onOptOut() {}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRow(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dataType = dataSource.dataType(for: indexPath) {
            switch dataType {
            case .myAccountOffline:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeOfflineCell {
                    cell.viewModel = HomeOfflineCell.HomeOfflineViewModel(title: "My Account")
                    return cell
                }
            case .myAccount:
                break
            case .myExpensesOffline:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeOfflineCell {
                    cell.viewModel = HomeOfflineCell.HomeOfflineViewModel(title: "My Expenses")
                    return cell
                }
            case .myExpenses:
                break
            case .myInvestmentOffline:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeOfflineCell {
                    cell.viewModel = HomeOfflineCell.HomeOfflineViewModel(title: "My Investment")
                    return cell
                }
            case .myInvestment:
                break
            case .connect:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeLoginCellIdentifier, for: indexPath) as? HomeLoginCell {
                    cell.viewModel = HomeLoginCell.HomeLoginViewModel(title: "Login")
                    return cell
                }
            default:
                break
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataType = dataSource.dataType(for: indexPath), dataType == .connect {
            FlybitsManager.environment = FlybitsManager.Environment.productionUS
            // start loading
            startLoading()
            
            // create an IDP
            let myIDP = FlybitsIDP(email: "nuo.xu@flybits.com", password: "K2iA3WsF[R")
            // connect Flybits with your IDP and a projectID
            FlybitsManager.connect(myIDP, customerId: "", projectId: "D57EBC96-209B-44F7-88F7-091EF8CEA4B5") { [weak self] user, error in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.stopLoading()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
}
