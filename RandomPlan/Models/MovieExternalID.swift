//
//  MovieExternalID.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 01/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

struct MovieExternalID: Codable, Hashable {
    
    var id: Int
    var imdbId: String
    var instagramId:String?
    var twitterId: String?
    
}
