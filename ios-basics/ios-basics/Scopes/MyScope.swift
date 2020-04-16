//
//  MyScope.swift
//  ios-basics
//
//  Created by Nuo Xu on 2020-04-14.
//  Copyright © 2020 MikeH. All rights reserved.
//

import Foundation
import FlybitsSDK

class MyScope: FlybitsScope {
    
    var identifier: String = UUID().uuidString
    
    func onConnected(user: User) {
        // fetch favourites that are stored on Flybits server
        let _ = FlybitsPreference.getFavorites { favourites, error in
            // Store the list of favourites to doc directory
            self.write(favourites: favourites)
        }
    }
    
    func onDisconnected(jwtToken: String) {
        // Remove `Favourites.plist` from doc directory
        let docDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let docURL = docDirectoryURL.appendingPathComponent("Favourites.plist")
        do {
            try FileManager.default.removeItem(at: docURL)
        } catch {
            print(error)
        }
    }
    
    func onAccountDestroyed(jwtToken: String) {
    }
    
    func onOptIn() {
    }
    
    func onOptOut() {
    }
    
    func encode(with coder: NSCoder) {
    }
    
    required init?(coder: NSCoder) {
        // nothing to do
    }
    
    init() {
        // nothing to do
    }
    
    private func write(favourites: [String]) {
        let docDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let docURL = docDirectoryURL.appendingPathComponent("Favourites.plist")
       
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: ["favourites": favourites], format: .xml, options: 0)
            try plistData.write(to: docURL)
        } catch {
            print(error)
        }
    }
}
