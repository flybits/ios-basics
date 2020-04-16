//
//  LocationData.swift
//  ios-basics
//
//  Created by MikeH on 2019-12-06.
//  Copyright © 2019 MikeH. All rights reserved.
//

import Foundation
import FlybitsKernelSDK

class LocationContent: ContentData {

    var imgCover: URL?
    var name: String?

    required init?(responseData: Any) throws {
        try super.init(responseData: responseData)
        guard let responseData = responseData as? [String: Any] else { assert(false); return }

        imgCover = URL(string: (responseData["imgCover"] as? String)!)
        name = responseData["txtName"] as? String

    }

    override var description: String {
        return "\(name),\(imgCover)"
    }

}
