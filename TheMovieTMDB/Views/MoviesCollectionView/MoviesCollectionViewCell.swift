//
//  MoviesCollectionViewCell.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfiguration() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
}

extension MoviesCollectionViewCell {
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
           imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
           
           titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
           titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
       ])
}
}

