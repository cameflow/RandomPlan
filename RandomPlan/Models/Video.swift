//
//  Video.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 07/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import Foundation

struct Video: Decodable {
    
    var videoId: String
    var title: String
    var description: String
    var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case thumbnails
        case high
        case resourceId
        case thumbnail      = "url"
        case videoId
        case title
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer        = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        self.title                  = try snippetContainer.decode(String.self, forKey: .title)
        self.description            = try snippetContainer.decode(String.self, forKey: .description)
        
        let thumbnailsContainer     = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highThumbnailContainer  = try thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail              = try highThumbnailContainer.decode(String.self, forKey: .thumbnail)
        
        let resourceIdContainer     = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId                = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
    
}
