//
//  UIView+AutoLayout.swift
//  ios-basics
//
//  Created by Nuo Xu on 2020-04-15.
//  Copyright © 2020 MikeH. All rights reserved.
//

import Foundation

import UIKit

extension NSLayoutConstraint {
    public func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

public protocol Constrainable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Constrainable {}
extension UILayoutGuide: Constrainable {}

public extension UIView {
    @discardableResult
    func pin(_ constraints: [NSLayoutConstraint]) -> Self {
        NSLayoutConstraint.activate(constraints)
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func pin(to constrainable: Constrainable, insets: UIEdgeInsets = .zero) -> Self {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: constrainable.leftAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: constrainable.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: constrainable.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: constrainable.bottomAnchor, constant: -insets.bottom)
        ])
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
