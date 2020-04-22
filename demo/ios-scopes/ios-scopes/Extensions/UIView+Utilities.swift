//
//  UIView+Utilities.swift
//  ios-basics
//
//  Created by Nuo Xu on 2020-04-15.
//  Copyright © 2020 MikeH. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    private class func getAllSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(view: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }
    
    func getAllSubviews<T: UIView>() -> [T] {
        return self.subviews.flatMap { subview -> [T] in
            var result = subview.getAllSubviews() as [T]
            if let view = subview as? T {
                result.append(view)
            }
            return result
        }
    }

    func subviews(where: (_ view: UIView) -> Bool) -> [UIView] {
        return self.subviews.flatMap { subview -> [UIView] in
            var result = subview.subviews(where: `where`)
            if `where`(subview) {
                result.append(subview)
            }
            return result
        }
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ arrangedSubViews: [UIView]) {
        for arrangedSubView in arrangedSubViews {
            addArrangedSubview(arrangedSubView)
        }
    }
}
