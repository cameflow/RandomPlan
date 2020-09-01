//
//  Movie.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 31/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    
    var id: Int
    var originalTitle: String
    var title:String
    var overview: String
    
}
