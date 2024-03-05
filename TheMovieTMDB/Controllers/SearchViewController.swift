//
//  SearchViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 5.03.24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var moviesArray: Movies?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .white
        return searchBar
    }()
  
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
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        self.searchBar.delegate = self
    }
    
    private func getMovies(query: String) {
        let endpoint = EndpointMovie.getMoviesOn(query: query)
        NetworkManager.getMovies(endpoint: endpoint) { result in
            switch result {
            case .failure(_): return
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.moviesArray = movies
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == "" {
                moviesArray = nil
            }
            getMovies(query: searchText)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenMovieViewController()
        if let id = moviesArray?.results[indexPath.row].id {
            let idString = String(id)
            vc.completionHandler = { return idString }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController {
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
