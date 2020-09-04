//
//  RPTabBarController.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 25/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class RPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemRed
        viewControllers                 = [createMainScreenNC(), createRandomMovieNC(), createSettingsVC()]
    }
    

    func createMainScreenNC() -> UINavigationController {
        let mainScreen          = MainVC()
        mainScreen.tabBarItem   = UITabBarItem(title: "Main", image: UIImage(systemName: "map"), tag: 0)
        
        return UINavigationController(rootViewController: mainScreen)
    }
    
    func createRandomMovieNC() -> UINavigationController {
        let randomMovie         = MoviesVC()
        randomMovie.tabBarItem  = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 1)
        
        return UINavigationController(rootViewController: randomMovie)
    }
    
    func createSettingsVC() -> UINavigationController {
        let settingsScreen  = SettingsVC()
        settingsScreen.tabBarItem   = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        return UINavigationController(rootViewController: settingsScreen)
    }

}


