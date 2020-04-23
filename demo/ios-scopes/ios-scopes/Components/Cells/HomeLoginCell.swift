//
//  HomeLoginCell.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class HomeLoginCell: UICollectionViewCell {
    
    private var loginLabel = UILabel()
    
    // MARK: - ViewModel
    struct HomeLoginViewModel {
        let title: String
    }
    
    var viewModel: HomeLoginViewModel? {
        didSet {
            if let viewModel = viewModel {
                loginLabel.text = viewModel.title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .loginButtonColor
        
        loginLabel.font = .systemFont(ofSize: 14.0)
        loginLabel.textAlignment = .center
        
        contentView.addSubview(loginLabel)
        loginLabel.pin(to: self, padding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
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
