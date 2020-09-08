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
    var searchTerm          = ""
    var playlistId          = ""
    var settings            = ["Place": 0, "Active": 0, "Food": 0, "Time": 0, "Cost": 0]
    var planPlace           = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        getSettings()
        configureView()
        configureLabels()
        configureBackground()
        configureButton()
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
            
            descriptionLabel.topAnchor.constraint(equalTo: planLabel.bottomAnchor, constant: 50),
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
    
    func filterPlan(parameter: Int, settingValue: Int, settingName: String) -> Bool {
        if settingName == "Place" {
            if settingValue != 3 { return parameter == settingValue } else { return true }
        } else if settingName == "Time" {
            if parameter == 2 || settingValue == 2 { return true } else { return parameter == settingValue }
        } else {
            if settingValue != 2 { return parameter == settingValue } else { return true }
        }
    }
    
    @objc func selectPlan() {
        let plans = plansData.filter { filterPlan(parameter: $0.active, settingValue: settings["Active"] ?? 2, settingName:                                         "Active") &&
                                       filterPlan(parameter: $0.time, settingValue: settings["Time"] ?? 2, settingName: "Time") &&
                                       filterPlan(parameter: $0.food, settingValue: settings["Food"] ?? 2, settingName: "Food") &&
                                       filterPlan(parameter: $0.place, settingValue: settings["Place"] ?? 2, settingName: "Place") &&
                                       filterPlan(parameter: $0.cost, settingValue: settings["Cost"] ?? 2, settingName: "Cost") }
        
 
        if let selectedPlan = plans.randomElement() {
            planLabel.text          = selectedPlan.title
            descriptionLabel.text   = selectedPlan.description
            background.image        = UIImage(named: selectedPlan.background)
            searchTerm              = selectedPlan.searchTerm
            planPlace               = selectedPlan.place
            if selectedPlan.place == 2 {
                button.setTitle("What can I do?", for: .normal)
                playlistId = selectedPlan.playlistId ?? ""
            }
        } else {
            planLabel.text          = "No plan available"
            descriptionLabel.text   = "There is no plan that matches your settings.\n Go to your settings and change them"
            searchTerm              = ""
        }
        
    }
    
    @objc func goToMap() {
        var destVc:UIViewController
        if planPlace == 2 {
            destVc = VideosVC(playlistId: playlistId)
        } else {
            destVc = MapVC(plan: searchTerm)
        }
        
        navigationController?.pushViewController(destVc, animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func getSettings() {
        for (key, _) in settings {
            PersistenceManager.retreiveSetting(key: key) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let setting):
                    self.settings[key] = setting
                case .failure(let error):
                    let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    

}
