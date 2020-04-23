//
//  HomeMyAccountCell.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-23.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class MyAccountTitleView: UIView {
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        titleLabel.text = "My Account"
        
        addSubview(titleLabel)
        titleLabel.pin(to: self, padding: UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyAccountView: UIView {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let balanceLabel = UILabel()
    
    // MARK: - ViewModel
    struct MyAccountViewModel {
        let title: String
        let balance: String
    }
    
    var viewModel: MyAccountViewModel? {
        didSet {
            if let viewModel = viewModel {
                titleLabel.text = viewModel.title
                balanceLabel.text = viewModel.balance
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
        
        titleLabel.font = .systemFont(ofSize: 14.0)
        
        balanceLabel.font = .systemFont(ofSize: 14.0)
        balanceLabel.textAlignment = .right
        
        addSubview(stackView)
        stackView.pinToSuperView()
        
        stackView.addArrangedSubviews([titleLabel, balanceLabel])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeMyAccountCell: UICollectionViewCell {
    
    private let stackView = UIStackView()
    private let titleView = MyAccountTitleView()
    private let savingAccountView = MyAccountView()
    private let chequingAccountView = MyAccountView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10.0, leading: 0.0, bottom: 10.0, trailing: 0.0)
        
        savingAccountView.viewModel = MyAccountView.MyAccountViewModel(title: "SAVING ACCOUNT", balance: "$12,905.89")
        chequingAccountView.viewModel = MyAccountView.MyAccountViewModel(title: "CHEQUING ACCOUNT", balance: "$7,905.64")
        
        contentView.addSubview(stackView)
        stackView.pinToSuperView()
        
        stackView.addArrangedSubviews([titleView, savingAccountView, chequingAccountView])

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 15.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
    }
}