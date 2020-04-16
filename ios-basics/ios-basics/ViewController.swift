//
//  ViewController.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
import FlybitsKernelSDK
import FlybitsSDK
import CoreLocation

class ViewController: UIViewController {
    
    // Mark: - Constants
    struct Constants {
        static let mainScreenCellIdentifier = "MainScreenCellIdentifier"
        static let defaultCellIdentifier = "DefaultCellIdentifier"
        static let options = ["Relevant Content", "Scopes"]
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iOS-Basic"
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.pin(to: view)
        
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: Constants.mainScreenCellIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellIdentifier)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mainScreenCellIdentifier, for: indexPath) as? MainViewCell {
            
            cell.viewModel = MainViewCell.ViewModel(name: Constants.options[indexPath.row])
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.defaultCellIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let contentTableVC = ContentTableViewController()
            navigationController?.pushViewController(contentTableVC, animated: true)
        case 1:
            let scopesVC = ScopesViewController()
            navigationController?.pushViewController(scopesVC, animated: true)
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 44.0)
    }
}

// MARK: - MainViewCell

class MainViewCell: UICollectionViewCell {
    
    // MARK: - Design
    struct Design {
        static let titleLabelInsects = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    // MARK: - ViewModel
    struct ViewModel {
        let name: String
    }
    
    private let titleLabel = UILabel()
    
    var viewModel: MainViewCell.ViewModel? {
        didSet {
            if let viewModel = viewModel {
                titleLabel.text = viewModel.name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .groupTableViewBackground
        
        addSubview(titleLabel)
        titleLabel.pin(to: self, insets: Design.titleLabelInsects)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

