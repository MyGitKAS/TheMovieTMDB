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
        
        tabBar.backgroundColor = .lightGray

        let firstViewController = RatingMoviesViewController()
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        firstNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        let secondViewController = FullScreenMovieViewController()
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        secondNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        let thirdViewController = UIViewController()
        let thirdNavController = UINavigationController(rootViewController: thirdViewController)
        thirdNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)

        self.viewControllers = [firstNavController, secondNavController, thirdNavController]

    }
}

