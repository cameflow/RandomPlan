//
//  VideoCell.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 07/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    static let reuseID  = "VideoCell"
    let titleLabel      = RPBodyLabel(textAlignment: .left)
    let thumbnailImage  = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: Video) {
        titleLabel.text = video.title
        NetworkManager.shared.getPoster(from: video.thumbnail) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.thumbnailImage.image = image
            }
        }
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(thumbnailImage)
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 60),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
