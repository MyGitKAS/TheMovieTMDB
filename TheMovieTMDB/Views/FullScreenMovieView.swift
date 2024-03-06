//
//  FullScreenMovieView.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit


class FullScreenMovieView: UIView {
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private var horisontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var genreStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .medium)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = .orange
        label.numberOfLines = 0
        return label
    }()
    
    private var productionCountryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private var posterView: PosterView = {
        let imageView = PosterView(frame: .zero)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.extraLarge.getSize(), weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize() , weight: .regular)
        return label
    }()
    
    private var budgetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var budgetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.text = "Budget"
        label.numberOfLines = 1
        return label
    }()
    
    private var budgetDigitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        label.numberOfLines = 1
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
        backgroundColor = .white
        self.addSubview(scrollView)
        scrollView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(posterView)
        verticalStack.addArrangedSubview(budgetStack)
        budgetStack.addArrangedSubview(budgetTitleLabel)
        budgetStack.addArrangedSubview(budgetDigitLabel)
        verticalStack.addArrangedSubview(productionCountryLabel)
        verticalStack.addArrangedSubview(genreStack)
        genreStack.addArrangedSubview(genreLabel)
        genreStack.addArrangedSubview(durationLabel)
        verticalStack.addArrangedSubview(overviewLabel)
    }
    
    func setupData(movie: Movie, poster: UIImage) {
        self.titleLabel.text = movie.title
        self.budgetDigitLabel.text = "\(movie.budget ?? 000_000)$"
        self.genreLabel.text = movie.genres?.first?.name
        self.overviewLabel.text = movie.overview
        self.productionCountryLabel.text = movie.productionCountries?.first?.name
        self.durationLabel.text = String(movie.runtime ?? 000) + "min"
        self.posterView.image = poster
        self.posterView.setData(rating: movie.getFormattedVoteAverage() ?? "00.0", votesCount: movie.voteCount ?? 000)
        
    }
}

extension FullScreenMovieView {
    private func setupConstraints() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
        ])
    }
}


