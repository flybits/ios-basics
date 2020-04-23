//
//  HomeDataSource.swift
//  ios-scopes
//
//  Created by Nuo Xu on 2020-04-22.
//  Copyright © 2020 Nuo Xu. All rights reserved.
//

import Foundation
import FlybitsSDK

enum HomeDataType {
    case myAccountOffline
    case myAccount
    case myExpensesOffline
    case myExpenses
    case myInvestmentOffline
    case myInvestment
    case connect
    case unknown
}

struct HomeDataSource {
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRow(for section: Int) -> Int {
        return FlybitsManager.isConnected ? 3 : 4
    }
    
    func dataType(for indexPath: IndexPath) -> HomeDataType? {
        switch indexPath.row {
        case 0:
            return FlybitsManager.isConnected ? .myAccount : .myAccountOffline
        case 1:
            return FlybitsManager.isConnected ? .myExpenses : .myExpensesOffline
        case 2:
            return FlybitsManager.isConnected ? .myInvestment : .myInvestmentOffline
        case 3:
            return .connect
        default:
            return .unknown
        }
    }
}