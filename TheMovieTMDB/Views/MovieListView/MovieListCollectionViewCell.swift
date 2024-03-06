//
//  MovieListCollectionViewCell.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 4.03.24.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize() , weight: .bold)
        label.numberOfLines = 4
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize() , weight: .medium)
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize() , weight: .bold)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    }()
    
   private let productionCountries: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize() , weight: .light)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = Constants.elementCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
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
        self.layer.cornerRadius = Constants.elementCornerRadius
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: Constants.elementCornerRadius).cgPath
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(productionCountries)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(releaseLabel)
        horizontalStackView.addArrangedSubview(voteAverageLabel)
        addSubview(stackView)
    }
    
    func setData(movie: Movie) {
        self.titleLabel.text = movie.title
        self.releaseLabel.text = movie.getReleaseYear()
        self.productionCountries.text = movie.tagline ?? "???????"
        if let rate = movie.getFormattedVoteAverage() {
            self.voteAverageLabel.text = "\(rate)★"
        }
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
}

extension MovieListCollectionViewCell {
    private func setupConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            imageView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
