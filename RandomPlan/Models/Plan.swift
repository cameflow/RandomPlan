//
//  Plan.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 05/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

struct Plan: Codable, Hashable, Identifiable {
    
    var id: Int
    var title: String
    var description: String
    var searchTerm: String
    var background: String
    var place: Int
    var active: Int
    var food: Int
    var time: Int
    var cost: Int
    
}
