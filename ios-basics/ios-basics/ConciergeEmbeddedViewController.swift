//
//  ContentTableViewController.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
import FlybitsConciergeSDK
import FlybitsSmartRewardsSDK

class ConciergeEmbeddedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func showConcierge(_ sender: Any) {
        if !FlybitsConciergeManager.isConnected {
            FlybitsConciergeManager.shared.connectFlybitsManager(to: "7DE8F413-95FC-4FF9-B1C9-D51ACB4ECDEC", with: AnonymousIDP()) { (error) in
               DispatchQueue.main.async {
                let viewController = FlybitsConciergeManager.shared.navigationController()
                  self.present(viewController, animated: true, completion: nil)
              }
            }
        } else {
            DispatchQueue.main.async {
                let viewController = FlybitsConciergeManager.shared.navigationController()
               self.present(viewController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func disconnect(_ sender: Any) {
        FlybitsConciergeManager.shared.disconnectFlybitsManager { (error) in
        }
    }

}
