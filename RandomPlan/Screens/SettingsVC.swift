//
//  SettingsVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 03/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var placeLabel          = RPBodyLabel(textAlignment: .left)
    var activeLabel         = RPBodyLabel(textAlignment: .left)
    var foodLabel           = RPBodyLabel(textAlignment: .left)
    var timeLabel           = RPBodyLabel(textAlignment: .left)
    var costLabel           = RPBodyLabel(textAlignment: .left)
    var segmentedControl    = UISegmentedControl()
    var segmentedControl_02 = UISegmentedControl()
    var segmentedControl_03 = UISegmentedControl()
    var segmentedControl_04 = UISegmentedControl()
    var segmentedControl_05 = UISegmentedControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configturePlaceLabel()
        configureSegmentedControl_01()
        configureActiveLabel()
        configureSegmentedControl_02()
        configureFoodLabel()
        configureSegmentedControl_03()
        configureTimeLabel()
        configureSegmentedControl_04()
        configureCostLabel()
        configureSegmentedControl_05()
    }
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Settings"
    }
    
    private func configturePlaceLabel() {
        view.addSubview(placeLabel)
        
        placeLabel.text = "Where do you want your plan?"
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            placeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            placeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSegmentedControl_01() {
        let segments = ["Indoors", "Outdoors", "Home", "Any"]
        
        segmentedControl                            = UISegmentedControl(items: segments)
        segmentedControl.selectedSegmentTintColor   = .systemRed
        PersistenceManager.retreiveSetting(key: "Place") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let setting):
                self.segmentedControl.selectedSegmentIndex = setting
            case .failure(_):
                self.segmentedControl.selectedSegmentIndex = 0
            }
        }
        segmentedControl.backgroundColor            = .secondarySystemBackground
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints  = false
        segmentedControl.addTarget(self, action: #selector(savePlace(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: placeLabel.topAnchor, constant: 30),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configureActiveLabel() {
        view.addSubview(activeLabel)
        activeLabel.text = "Do you want an active plan?"
        activeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activeLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            activeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            activeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            activeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSegmentedControl_02() {
        let segments = ["Active", "Not Active", "Any"]
        
        segmentedControl_02                            = UISegmentedControl(items: segments)
        segmentedControl_02.selectedSegmentTintColor   = .systemRed
        PersistenceManager.retreiveSetting(key: "Active") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let setting):
                self.segmentedControl_02.selectedSegmentIndex = setting
            case .failure(_):
                self.segmentedControl_02.selectedSegmentIndex = 0
            }
        }
        segmentedControl_02.backgroundColor            = .secondarySystemBackground
        
        segmentedControl_02.translatesAutoresizingMaskIntoConstraints  = false
        segmentedControl_02.addTarget(self, action: #selector(saveActive(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl_02)
        
        NSLayoutConstraint.activate([
            segmentedControl_02.topAnchor.constraint(equalTo: activeLabel.topAnchor, constant: 30),
            segmentedControl_02.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl_02.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configureFoodLabel() {
        view.addSubview(foodLabel)
        foodLabel.text = "Do you want food to be part of your plan?"
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodLabel.topAnchor.constraint(equalTo: segmentedControl_02.bottomAnchor, constant: 30),
            foodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            foodLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            foodLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSegmentedControl_03() {
        let segments = ["Only food", "No Food", "Any"]
        
        segmentedControl_03                            = UISegmentedControl(items: segments)
        segmentedControl_03.selectedSegmentTintColor   = .systemRed
        PersistenceManager.retreiveSetting(key: "Food") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let setting):
                self.segmentedControl_03.selectedSegmentIndex = setting
            case .failure(_):
                self.segmentedControl_03.selectedSegmentIndex = 0
            }
        }
        segmentedControl_03.backgroundColor            = .secondarySystemBackground
        
        segmentedControl_03.translatesAutoresizingMaskIntoConstraints  = false
        segmentedControl_03.addTarget(self, action: #selector(saveFood(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl_03)
        
        NSLayoutConstraint.activate([
            segmentedControl_03.topAnchor.constraint(equalTo: foodLabel.topAnchor, constant: 30),
            segmentedControl_03.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl_03.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configureTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.text = "What time is your plan?"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: segmentedControl_03.bottomAnchor, constant: 30),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSegmentedControl_04() {
        let segments = ["Day", "Night", "Any"]
        
        segmentedControl_04                            = UISegmentedControl(items: segments)
        segmentedControl_04.selectedSegmentTintColor   = .systemRed
        PersistenceManager.retreiveSetting(key: "Time") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let setting):
                self.segmentedControl_04.selectedSegmentIndex = setting
            case .failure(_):
                self.segmentedControl_04.selectedSegmentIndex = 0
            }
        }
        segmentedControl_04.backgroundColor            = .secondarySystemBackground
        
        segmentedControl_04.translatesAutoresizingMaskIntoConstraints  = false
        segmentedControl_04.addTarget(self, action: #selector(saveTime(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl_04)
        
        NSLayoutConstraint.activate([
            segmentedControl_04.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 30),
            segmentedControl_04.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl_04.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func configureCostLabel() {
        view.addSubview(costLabel)
        costLabel.text = "Are you willing to pay?"
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: segmentedControl_04.bottomAnchor, constant: 30),
            costLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            costLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            costLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSegmentedControl_05() {
        let segments = ["Free", "Pay", "Any"]
        
        segmentedControl_05                            = UISegmentedControl(items: segments)
        segmentedControl_05.selectedSegmentTintColor   = .systemRed
        PersistenceManager.retreiveSetting(key: "Cost") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let setting):
                self.segmentedControl_05.selectedSegmentIndex = setting
            case .failure(_):
                self.segmentedControl_05.selectedSegmentIndex = 0
            }
        }
        segmentedControl_05.backgroundColor            = .secondarySystemBackground
        
        segmentedControl_05.translatesAutoresizingMaskIntoConstraints  = false
        segmentedControl_05.addTarget(self, action: #selector(saveCost(_:)), for: .valueChanged)
        
        
        view.addSubview(segmentedControl_05)
        
        NSLayoutConstraint.activate([
            segmentedControl_05.topAnchor.constraint(equalTo: costLabel.topAnchor, constant: 30),
            segmentedControl_05.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl_05.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    @objc func savePlace(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            PersistenceManager.saveSetting(value: 0, key: "Place")
        case 1:
            PersistenceManager.saveSetting(value: 1, key: "Place")
        case 2:
            PersistenceManager.saveSetting(value: 2, key: "Place")
        case 3:
            PersistenceManager.saveSetting(value: 3, key: "Place")
        default:
            print("none")
        }
    }
    
    @objc func saveActive(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            PersistenceManager.saveSetting(value: 0, key: "Active")
        case 1:
            PersistenceManager.saveSetting(value: 1, key: "Active")
        case 2:
            PersistenceManager.saveSetting(value: 2, key: "Active")
        default:
            print("none")
        }
    }
    
    @objc func saveFood(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            PersistenceManager.saveSetting(value: 0, key: "Food")
        case 1:
            PersistenceManager.saveSetting(value: 1, key: "Food")
        case 2:
            PersistenceManager.saveSetting(value: 2, key: "Food")
        default:
            print("none")
        }
    }
    
    @objc func saveTime(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            PersistenceManager.saveSetting(value: 0, key: "Time")
        case 1:
            PersistenceManager.saveSetting(value: 1, key: "Time")
        case 2:
            PersistenceManager.saveSetting(value: 2, key: "Time")
        default:
            print("none")
        }
    }
    
    @objc func saveCost(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            PersistenceManager.saveSetting(value: 0, key: "Cost")
        case 1:
            PersistenceManager.saveSetting(value: 1, key: "Cost")
        case 2:
            PersistenceManager.saveSetting(value: 2, key: "Cost")
        default:
            print("none")
        }
    }

}
