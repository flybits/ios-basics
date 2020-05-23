//
//  ViewController.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import UIKit
i
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        if !FlybitsManager.isConnected {
        FlybitsManager.connect(AnonymousIDP(), projectId: "7E6DAB4A-4F35-458F-991D-85FC0C02B348") { (user, error) in

            let query = ContentQuery(contentTypes: ["place": Place.self], labelsQuery: nil, pager: nil)
  //          query.locationQuery = LocationQuery(key: "address", location: CLLocationCoordinate2D(latitude: 37.76224645239545, longitude: -122.39189772883611), radius: 10000)


            _ = Content.getAllInstances(with: query) { (paged, error) in
                guard let p = paged?.elements else { return }

                p.forEach { (content) in
                    print(content.pagedContentData?.elements)
                }
            }
        }
    }


}

