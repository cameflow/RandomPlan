//
//  PersistanceManager.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 04/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static func retreiveSetting(key: String, completed: @escaping (Result<Int,RPError>) -> Void) {
        guard let setting = defaults.object(forKey: key) else {
            completed(.failure(.settingErrors))
            return
        }
        completed(.success(setting as! Int))
    }
    
    static func saveSetting(value: Int, key: String) {
        defaults.set(value, forKey: key)
    }
    
}
