//
//  MovieListViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 4.03.24.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    var completionHandler: (() -> String)?
    
    private var moviesArray: Movies?
    private var currentPage = 1
    private var genreID: String!
        
    private lazy var collectionView: MovieListView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = MovieListView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
    
    private func setupConfiguration() {
        genreID = completionHandler?() ?? ""
        getMovies(genreID: genreID, pageNumber: 1)
        view.addSubview(collectionView)
    }
    
    private func getMovies(genreID: String, pageNumber: Int) {
        let endpoint = EndpointMovie.moviesAtGenre(id: genreID, pageNumber: pageNumber)
        NetworkManager.getMovies(endpoint: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_): return
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    if self.moviesArray == nil {
                        self.moviesArray = movies
                    } else {
                        self.moviesArray?.results.append(contentsOf: movies.results)
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCollectionViewCell
        guard let movies = moviesArray else { return cell }
        let movie = movies.results[indexPath.row]
        let imageUrl = movies.results[indexPath.row].posterPath ?? ""
        let url = EndpointImage.posterUrl(width: 200, idImage: imageUrl).path()
        DispatchQueue.global().async {
            NetworkManager.downloadImageWith(urlString: url) { image in
                DispatchQueue.main.async {
                    cell.setData(movie: movie)
                    guard let image = image else {
                        cell.setImage(image: UIImage(named: "no_image")!)
                        return
                    }
                    cell.setImage(image: image)
                }
            }
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard let totalPage = moviesArray?.totalPages else { return }
            if currentPage < totalPage {
                currentPage += 1
                getMovies(genreID: genreID, pageNumber: currentPage)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenMovieViewController()
        if let id = moviesArray?.results[indexPath.row].id {
            let idString = String(id)
            vc.completionHandler = { return idString }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController {
    private func setupConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
