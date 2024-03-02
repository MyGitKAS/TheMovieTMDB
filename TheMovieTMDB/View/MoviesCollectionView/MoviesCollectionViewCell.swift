//
//  MoviesCollectionViewCell.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "DGFBTRBRTVRVR"
        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                   imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
                   
                   titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                   titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                   titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
               ])
    }
}

