//
//  HomeMyExpensesCell.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-23.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class MyExpensesTitleView: UIView {
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        titleLabel.text = "My Expenses"
        
        addSubview(titleLabel)
        titleLabel.pin(to: self, padding: UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeMyExpensesView: UIView {
    private let spentLabel = UILabel()
    private let subTitleLabel = UILabel()
       
    init() {
        super.init(frame: .zero)
       
        spentLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        spentLabel.textAlignment = .center
        spentLabel.text = "$2,562.75"
        
        subTitleLabel.font = .systemFont(ofSize: 12.0)
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = "SPENT SO FAR"
       
        addSubviews([spentLabel, subTitleLabel])
        spentLabel.pin([
            spentLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            spentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        subTitleLabel.pin([
            subTitleLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
}

class HomeMyExpensesCell: UICollectionViewCell {
    private let stackView = UIStackView()
    private let titleView = MyExpensesTitleView()
    private let expensesView = HomeMyExpensesView()
       
       
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = .white
       
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20.0, leading: 0.0, bottom: 20.0, trailing: 0.0)
        
        contentView.addSubview(stackView)
        stackView.pinToSuperView()
        
        stackView.addArrangedSubviews([titleView, expensesView])
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
