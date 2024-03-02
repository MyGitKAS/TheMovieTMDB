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
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.text = "Drama"
        label.numberOfLines = 0
        return label
    }()
    
    private var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.text = "1h 38m"
        label.numberOfLines = 0
        return label
    }()
    
    private var productionCountryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.text = "England"
        label.numberOfLines = 0
        return label
    }()
    
    private var ratingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "test_poster")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var productionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "Warner Brathers Co"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Lilith (Blanchett), an infamous bounty hunter with a mysterious past, reluctantly returns to her home, Pandora, the most chaotic planet in the galaxy. Her mission is to find the missing daughter of Atlas (Ramírez), the universe's most powerful S.O.B. Lilith forms an unexpected alliance with a ragtag team of misfits - Roland (Hart), a seasoned mercenary on a mission; Tiny Tina (Greenblatt), a feral preteen demolitionist; Krieg (Munteanu), Tina's musclebound protector; Tannis (Curtis), the oddball scientist who's seen it all; and Claptrap (Black), a wiseass robot"
        label.font = UIFont.systemFont(ofSize: 15 , weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Budget"
        label.numberOfLines = 1
        return label
    }()
    
    
    private var budgetDigitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "18300000$"
        label.numberOfLines = 1
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = " 8.7 / 10 ★"
        label.backgroundColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = " 18+ "
        label.backgroundColor = .orange
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
        verticalStack.addArrangedSubview(imageView)
        ratingStack.addArrangedSubview(ratingLabel)
        ratingStack.addArrangedSubview(ageLabel)
        imageView.addSubview(ratingStack)
        verticalStack.addArrangedSubview(productionLabel)
        
        verticalStack.addArrangedSubview(budgetStack)
        budgetStack.addArrangedSubview(budgetTitleLabel)
        budgetStack.addArrangedSubview(budgetDigitLabel)
        
        verticalStack.addArrangedSubview(genreStack)
        genreStack.addArrangedSubview(genreLabel)
        genreStack.addArrangedSubview(durationLabel)
        genreStack.addArrangedSubview(productionCountryLabel)
        
        verticalStack.addArrangedSubview(overviewLabel)
    }
}

extension FullScreenMovieView {
    private func setupConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            ratingStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            ratingStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}


