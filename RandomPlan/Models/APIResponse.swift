//
//  APIResponse.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 31/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

struct APIResponse: Codable, Hashable {
    
    var page:Int
    var results:[Movie]
    
}
