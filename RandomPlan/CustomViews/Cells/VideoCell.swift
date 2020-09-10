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
        thumbnailImage.contentMode = .scaleAspectFill
        thumbnailImage.layer.cornerRadius   = 10
        thumbnailImage.layer.borderWidth    = 1
        thumbnailImage.layer.borderColor    = UIColor.systemGray2.cgColor
        thumbnailImage.clipsToBounds        = true
        titleLabel.numberOfLines            = 0
        
        accessoryType                       = .disclosureIndicator
        let padding: CGFloat                = 20
        
        NSLayoutConstraint.activate([
            thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            thumbnailImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -padding),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 180),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            titleLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
