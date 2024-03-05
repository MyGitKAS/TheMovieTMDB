//
//  ViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = Constants.mainColor
        
        let firstViewController = RatingMoviesViewController()
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        firstNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        let secondViewController = UpcomingMoviesViewController()
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        secondNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)

        let thirdViewController = GenresViewController()
        let thirdNavController = UINavigationController(rootViewController: thirdViewController)
        thirdNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)

        self.viewControllers = [firstNavController, secondNavController, thirdNavController]
    }
}

