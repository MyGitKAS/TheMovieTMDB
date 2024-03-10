//
//  GenresViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 3.03.24.
//

import UIKit

final class GenresViewController: UIViewController {
    
    private var genres: Genres?
    
    private lazy var collectionView: GenresCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = GenresCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: "GenresCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
    
    private func setupConfiguration() {
        self.navigationItem.title = "Choose your genre"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        view.addSubview(collectionView)
        let Endpoint = EndpointMovie.genres
        NetworkManager.getGenres(endpoint: Endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_): return
            case.success(let genres):
                DispatchQueue.main.async {
                    self.genres = genres
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc private func searchButtonTapped() {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GenresViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCollectionViewCell
        guard let genres = genres else { return cell }
        let text = genres.genres[indexPath.row].name
        cell.setTitle(title: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieListViewController()
        if let id = genres?.genres[indexPath.row].id {
            let idString = String(id)
            vc.completionHandler = { return idString }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GenresViewController {
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
