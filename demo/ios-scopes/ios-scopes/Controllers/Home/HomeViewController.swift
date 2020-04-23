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
        static let homeMyAccountCellIdentifier = "homeMyAccountCellIdentifier"
        static let homeMyExpensesCellIdentifier = "homeMyExpensesCellIdentifier"
        static let homeMyInvestmentCellIdentifier = "homeMyInvestmentCellIdentifier"
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ABC Bank"
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerClasses() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellIdentifier)
        collectionView.register(HomeRegularCell.self, forCellWithReuseIdentifier: Constants.homeOfflineCellIdentifier)
        collectionView.register(HomeLoginCell.self, forCellWithReuseIdentifier: Constants.homeLoginCellIdentifier)
        collectionView.register(HomeMyAccountCell.self, forCellWithReuseIdentifier: Constants.homeMyAccountCellIdentifier)
        collectionView.register(HomeMyExpensesCell.self, forCellWithReuseIdentifier: Constants.homeMyExpensesCellIdentifier)
        collectionView.register(HomeMyInvestmentCell.self, forCellWithReuseIdentifier: Constants.homeMyInvestmentCellIdentifier)
    }
    
    private func doLayout() {
        view.addSubview(collectionView)
        collectionView.pinToSuperView()
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
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "My Account")
                    return cell
                }
            case .myAccount:
                return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeMyAccountCellIdentifier, for: indexPath)
            case .myExpensesOffline:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "My Expenses")
                    return cell
                }
            case .myExpenses:
                return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeMyExpensesCellIdentifier, for: indexPath)
            case .myInvestmentOffline:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "My Investment")
                    return cell
                }
            case .myInvestment:
                return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeMyInvestmentCellIdentifier, for: indexPath)
            case .connect:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeLoginCellIdentifier, for: indexPath) as? HomeLoginCell {
                    cell.viewModel = HomeLoginCell.HomeLoginViewModel(title: "Login")
                    return cell
                }
            case .transfer:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "Transfer")
                    return cell
                }
            case .bills:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "Bills")
                    return cell
                }
            case .openAccount:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "Open A New Account")
                    return cell
                }
            case .quote:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "Quote")
                    return cell
                }
            case .faq:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "FAQ")
                    return cell
                }
            case .terms:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeOfflineCellIdentifier, for: indexPath) as? HomeRegularCell {
                    cell.viewModel = HomeRegularCell.HomeRegularViewModel(title: "Terms & Conditions")
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
        let sectionInsects = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        if let dataType = dataSource.dataType(for: indexPath) {
            if dataType == .myAccount {
                return CGSize(width: collectionView.frame.width - sectionInsects.left - sectionInsects.right, height: 120.0)
            } else if dataType == .myExpenses {
                 return CGSize(width: collectionView.frame.width - sectionInsects.left - sectionInsects.right, height: 140.0)
            } else if dataType == .myInvestment {
                 return CGSize(width: collectionView.frame.width - sectionInsects.left - sectionInsects.right, height: 120.0)
            }
        }
        
        return CGSize(width: collectionView.frame.width - sectionInsects.left - sectionInsects.right, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
}
