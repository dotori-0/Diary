//
//  TabBarController.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        homeNC.tabBarItem.title = "홈"
        homeNC.tabBarItem.image = UIImage(systemName: "house")
        homeNC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem.title = "설정"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        
        setViewControllers([homeNC, settingsVC], animated: true)
    }
}
