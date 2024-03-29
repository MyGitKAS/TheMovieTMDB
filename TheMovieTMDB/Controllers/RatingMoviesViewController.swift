//
//  TopMoviesViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

final class RatingMoviesViewController: UIViewController {
    
    private var moviesArray: Movies?
    private var currentPage = 1
    
    private let topSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Top popular", "Top rating"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = Constants.mainColor
        segmentedControl.backgroundColor = .clear
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    private lazy var collectionView: MoviesCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
    
    private func setupConfiguration() {
        getMovies(pageNumber: currentPage)
        view.addSubview(collectionView)
        view.addSubview(topSegmentedControl)
        self.navigationItem.title = "Popular Movies"
        self.navigationController?.view.backgroundColor = .white
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentPage = 1
        moviesArray = nil
        getMovies(pageNumber: currentPage)
    }
    
    
    private func getMovies(pageNumber: Int) {
        let endpoint: EndpointMovie
        switch topSegmentedControl.selectedSegmentIndex {
        case 0:
            endpoint = .popularMovies(pageNumber: pageNumber)
        case 1:
            endpoint = .ratedMovies(pageNumber: pageNumber)
        default:
            return
        }
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

extension RatingMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell", for: indexPath) as! MoviesCollectionViewCell
        guard let movies = moviesArray else { return cell }
        cell.setTitle(title: movies.results[indexPath.row].title ?? "No title")
        let imageUrl = movies.results[indexPath.row].posterPath ?? ""
        let url = EndpointImage.posterUrl(width: 200, idImage: imageUrl).path()
        DispatchQueue.global().async {
            NetworkManager.downloadImageWith(urlString: url) { image in
                DispatchQueue.main.async {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray?.results.count ?? 0
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenMovieViewController()
        if let id = moviesArray?.results[indexPath.row].id {
            let idString = String(id)
            vc.completionHandler = { return idString }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RatingMoviesViewController {
    private func setupConstraints() {
        
        topSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            topSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: topSegmentedControl.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



