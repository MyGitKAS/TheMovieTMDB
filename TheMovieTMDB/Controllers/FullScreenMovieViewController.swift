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
          NetworkManager.getOneMovie(endpoint: endpoint) { [weak self] result in
              guard let self = self else { return }
              switch result {
              case .failure(_): return
              case .success(let movie):
                  guard let movie = movie else { return }
                  guard let posterPath = movie.posterPath else {
                      DispatchQueue.main.async {
                          self.mainView.setupData(movie: movie, poster: UIImage(named: "no_image")!)
                      }
                      return
                  }
                  self.getImage(imagePath: posterPath) { image in
                      DispatchQueue.main.async {
                          guard let image = image else { return }
                          self.mainView.setupData(movie: movie, poster: image )
                      }
                  }
              }
          }
      }
}


