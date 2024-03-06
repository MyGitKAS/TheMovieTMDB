//
//  UpcomingViewCell.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 5.03.24.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        contentView.addSubview(stackView)
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
}

extension UpcomingCollectionViewCell {
    private func setupConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
