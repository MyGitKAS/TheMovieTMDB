//
//  FullScreenMovieViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class FullScreenMovieViewController: UIViewController {

    var mainView: FullScreenMovieView { return self.view as! FullScreenMovieView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FullScreenMovieView(frame: UIScreen.main.bounds)
        self.navigationItem.title = "Movie Title"
    }
  
}
