//
//  TopMoviesViewController.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class RatingMoviesViewController: UIViewController {
    
    private let topSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Top popular", "Top rating"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .orange
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    private lazy var collectionView: MoviesCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
    
    private func setupConfiguration() {
        view.addSubview(collectionView)
        view.addSubview(topSegmentedControl)
        self.navigationItem.title = "Popular Movies"
        self.navigationController?.view.backgroundColor = .lightGray
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
    }

 
}

extension RatingMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviesCollectionViewCell
        cell.imageView.image = UIImage(named: "test_poster")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}

extension RatingMoviesViewController {
    private func setupConstraints() {
        
        topSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            topSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topSegmentedControl.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
