//
//  DataManager.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setStatus(id: Int, status: Bool) {
        userDefaults.set(status, forKey: id.formatted())
    }
    
    func getStatus(id: Int) -> Bool {
        userDefaults.bool(forKey: id.formatted())
    }
}
