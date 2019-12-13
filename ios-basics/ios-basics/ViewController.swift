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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        if !FlybitsManager.isConnected {
        FlybitsManager.connect(AnonymousIDP(), projectId: "9DD55F62-F72B-42DA-893E-97958EEB0463") { (user, error) in

            let query = ContentQuery(contentTypes: ["place": LocationContent.self], labelsQuery: nil, pager: nil)
            query.locationQuery = LocationQuery(key: "address", location: CLLocationCoordinate2D(latitude: 37.76224645239545, longitude: -122.39189772883611), radius: 10000)


            _ = Content.getAllInstances(with: query) { (paged, error) in
                guard let p = paged?.elements else { return }

                p.forEach { (content) in
                    print(content.pagedContentData?.elements)
                }

            }
        }
//        } else {
//        }
    }


}

