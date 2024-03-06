//
//  UpcomingMoviesViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 5.03.24.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {
    
    private var moviesArray: Movies?
    private var currentPage = 1
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UpcomingCollectionViewCell.self, forCellWithReuseIdentifier: "UpcomingCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
    
    private func setupConfiguration() {
        self.view.addSubview(collectionView)
        self.navigationItem.title = "Comming soon movie"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: TextSize.extraLarge.getSize())]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        getMovies(pageNumber: currentPage)
    }
    
    
    private func getMovies(pageNumber: Int) {
        let endpoint = EndpointMovie.upcomingMovies(pageNumber: pageNumber)
        NetworkManager.getMovies(endpoint: endpoint) { result in
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

extension UpcomingMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCollectionViewCell
        guard let movies = moviesArray else { return cell }
        let imageUrl = movies.results[indexPath.row].posterPath ?? ""
        let url = EndpointImage.posterUrl(width: 300, idImage: imageUrl).path()
        DispatchQueue.global().async {
            NetworkManager.downloadImageWith(urlString: url) { image in
                DispatchQueue.main.async {
                    cell.setTitle(title: movies.results[indexPath.row].releaseDate ?? "No title")
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
                getMovies(pageNumber: currentPage)
            }
        }
    }
}

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height - 20
        return CGSize(width: width, height: height)
    }
}

extension UpcomingMoviesViewController {
    private func setupConstraints() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
           collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
           collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
