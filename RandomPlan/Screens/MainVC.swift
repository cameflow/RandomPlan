//
//  MainVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 25/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var timer_background: Timer!
    var timer_alpha: Timer!
    
    var background      = UIImageView()
    let titleText       = RPTitleLabel(textAlignment: .center, fontSize: 50)
    let button          = RPButton(backgroundColor: .systemRed, title: "Give me a plan!")
    var alpha:CGFloat   = 0.0
    var add             = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTimers()
        configureBackground()
        configureButton()
        configureTextLabel()
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureTimers() {
        timer_background = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(setRandomBackground), userInfo: nil, repeats: true)
        timer_alpha = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(changeAlpha), userInfo: nil, repeats: true)
    }
    
    func configureBackground() {
        view.addSubview(background)
        view.sendSubviewToBack(background)
        
        view.backgroundColor    = .systemBackground
        background.alpha        = alpha
        background.translatesAutoresizingMaskIntoConstraints = false
        
        self.setRandomBackground()
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func configureButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(getRandomPlan), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTextLabel() {
        view.addSubview(titleText)
        titleText.text          = "Let's go and do a fun activity!"
        titleText.numberOfLines = 3
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleText.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc func setRandomBackground() {
        let backgrounds = ["forest", "bowling", "movies", "park", "museum", "amusement", "aquarium", "boulder", "concert", "cooking", "gokart", "iceskate", "read", "yoga"]
        let random = Int(arc4random_uniform(UInt32 (backgrounds.count)))
        self.background.image = UIImage(named: backgrounds[random])
        alpha = 0.0
        add = true
    }
    
    @objc func getRandomPlan() {
        let destVC = RandomPlanVC()
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    @objc func changeAlpha() {
        if alpha >= 0.5 {
            add     = false
            alpha   = 0.5
        } else if alpha <= 0.0 {
            add     = true
            alpha   = 0.0
        }
        
        if add {
            alpha += 0.01
        } else {
            alpha -= 0.01
        }
        background.alpha = alpha
    }
    


}



