//
//  LocationData.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import Foundation
import FlybitsKernelSDK

struct GeoPoint {
    let lat: Double
    let lng: Double
}

class LocationContent: ContentData {

    var imgCover: URL?
    var name: String?
    
    var geoShape = [GeoPoint]()

    required init?(responseData: Any) throws {
        try super.init(responseData: responseData)
        guard let responseData = responseData as? [String: Any] else { assert(false); return }

        imgCover = URL(string: (responseData["imgCover"] as? String)!)
        name = responseData["txtName"] as? String
        
        print(responseData["shape"])
        if let geoPoints = responseData["shape"] as? [Dictionary<String, Double>] {
            for geoPoint in geoPoints {
                geoShape.append(GeoPoint(lat: geoPoint["lat"] ?? Double.zero, lng: geoPoint["lng"] ?? Double.zero))
            }
        }
        
        print(responseData)

    }

    override var description: String {
        return "\(name),\(imgCover)"
    }

}



