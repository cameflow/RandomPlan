//
//  MainVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 25/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var background = UIImageView()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        navigationController?.navigationBar.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(setRandomBackground), userInfo: nil, repeats: true)
        self.setRandomBackground()
    }
    
    func configureBackground() {
        view.addSubview(background)
        background.alpha = 0.3
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    @objc func setRandomBackground() {
        let colors = ["forest", "bowling", "movies", "park"]
        let random = Int(arc4random_uniform(UInt32 (colors.count)))
        self.background.image = UIImage(named: colors[random])
    }
    


}
