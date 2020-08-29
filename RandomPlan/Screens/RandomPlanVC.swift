//
//  RandomPlanVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 27/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class RandomPlanVC: UIViewController {
    
    var planLabel           = RPTitleLabel(textAlignment: .center, fontSize: 40)
    var descriptionLabel    = RPBodyLabel(textAlignment: .center)
    let button              = RPButton(backgroundColor: .systemRed, title: "Find a place!")
    var background          = UIImageView()
    
    let plans               = ["Hike!", "Bowling!", "Movies!", "Park!", "Museum!"]
    let backgrounds         = ["forest", "bowling", "movies", "park", "museum"]
    let plansDescriptions   = [
                                "Take some fresh air. Go for a hike and enjoy the nature. Be sure to bring snaks",
                                "Have fun making strikes at the bowling alley!",
                                "Action, Comedy, Scary. You choose! Go to the cinema and enjoy your movie",
                                "Nice day to go to a park. Enjoy the day and take a walk, maybe you can take a book and read or have a picnic",
                                "Today is a good day to learn something new. Go to a museum!",
                              ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLabels()
        configureBackground()
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectPlan()
    }
    
    func configureView() {
        view.backgroundColor                            = .systemBackground
        navigationController?.navigationBar.tintColor   = .systemRed
        navigationItem.rightBarButtonItem               = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem                = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(selectPlan))
    }
    
    func configureBackground() {
        view.addSubview(background)
        view.sendSubviewToBack(background)
        background.alpha = 0.3
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func configureLabels() {
        
        view.addSubview(planLabel)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.numberOfLines = 5
        
        NSLayoutConstraint.activate([
            planLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            planLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            planLabel.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: planLabel.bottomAnchor, constant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    func configureButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func selectPlan() {
        let selectedPlan        = Int(arc4random_uniform(UInt32 (plans.count)))
        planLabel.text          = plans[selectedPlan]
        descriptionLabel.text   = plansDescriptions[selectedPlan]
        background.image        = UIImage(named: backgrounds[selectedPlan])
    }
    
    @objc func goToMap() {
        let mapView = MapVC(plan: planLabel.text!)
        navigationController?.pushViewController(mapView, animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    

}
