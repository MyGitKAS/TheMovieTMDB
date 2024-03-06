//
//  FullScreenMovieViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit


class FullScreenMovieViewController: UIViewController {
    
    var completionHandler: (() -> String)?
    private var mainView: FullScreenMovieView!
    
    override func loadView() {
        self.view = FullScreenMovieView(frame: UIScreen.main.bounds)
        self.mainView = self.view as? FullScreenMovieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        let id = completionHandler?() ?? ""
        getMovie(id: id)
    }
    
    private func getImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        let url = EndpointImage.posterUrl(width: 400, idImage: imagePath).path()
        NetworkManager.downloadImageWith(urlString: url) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    private func getMovie(id: String) {
        let endpoint = EndpointMovie.movieFrom(id: id)
        NetworkManager.getOneMovie(endpoint: endpoint) { result in
            switch result {
            case .failure(_): return
            case .success(let movie):
                guard let movie = movie else { return }
                self.getImage(imagePath: movie.posterPath ?? "") { image in
                    DispatchQueue.main.async {
                        self.mainView.setupData(movie: movie, poster: image ?? UIImage(named: "no_image")!)
                    }
                }
            }
        }
    }
}


