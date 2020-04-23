//
//  UIView+AutoLayout.swift
//  ios-basics
//
//  Created by Nuo Xu on 2020-04-15.
//  Copyright © 2020 MikeH. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    @discardableResult
    func pin(_ constraints: [NSLayoutConstraint]) -> Self {
        NSLayoutConstraint.activate(constraints)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func pin(to view: UIView, padding: UIEdgeInsets = UIEdgeInsets.zero) -> Self {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding.left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding.right),
        ])
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func pinToSuperView() {
      guard let superView = superview else {
        fatalError("You need super view")
      }
      pin(to: superView)
    }
}
