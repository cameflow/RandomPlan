//
//  PosterVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 09/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class PosterVC: UIViewController {
    
    var imageView = UIImageView()
    
    init(image: UIImage){
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageView()

    }
    
    func configureImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    


}
