//
//  RootViewController.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-21.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var currentController: UIViewController
    
    init(controller: UIViewController) {
        self.currentController = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(currentController)
        currentController.didMove(toParent: self)
        view.addSubview(currentController.view)
    }

    func switchToViewController(controller: UIViewController,
                                duration: TimeInterval = 0.25,
                                animations: (() -> Void)? = nil,
                                completion: (() -> Void)? = nil) {
        controller.view.frame = view.bounds
        
        currentController.willMove(toParent: nil)
        addChild(controller)
        
        transition(from: currentController,
                   to: controller,
                   duration: duration,
                   options: .transitionCrossDissolve,
                   animations: {
                    if let animations = animations {
                        animations()
                    }
        }) { [weak self] _ in
            guard let self = self  else { return }
            self.currentController.removeFromParent()
            controller.didMove(toParent: self)
            self.currentController.view.removeFromSuperview()
            self.currentController = controller
            
            if let completion = completion {
                completion()
            }
        }
    }
}
