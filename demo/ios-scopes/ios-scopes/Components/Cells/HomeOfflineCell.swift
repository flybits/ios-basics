//
//  HomeOfflineCell.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class HomeOfflineCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    // MARK: - ViewModel
    struct HomeOfflineViewModel {
        let title: String
    }
    
    var viewModel: HomeOfflineViewModel? {
        didSet {
            if let viewModel = viewModel {
                titleLabel.text = viewModel.title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 14.0)
        
        addSubview(titleLabel)
        titleLabel.pin(to: self, padding: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
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
